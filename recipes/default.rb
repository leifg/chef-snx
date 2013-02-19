checkpoint_filename = node[:checkpoint][:checkpoint_install_filename]

%w{ia32-libs libpam0g:i386 libx11-6:i386 libstdc++5:i386 expect iptables}.each do | pkg |
  package pkg do 
    action :install
  end
end

execute 'copy checkpoint installation file' do
  command "cp #{node[:checkpoint][:checkpoint_install_source]}/#{checkpoint_filename} /tmp/"
  creates "/tmp/#{checkpoint_filename}"
end

bash 'extract installation tar' do
  cwd '/tmp'
  code %Q{
    mkdir -p SNX
    tar xzf #{checkpoint_filename} -C SNX
  }
  creates '/tmp/SNX'
end

bash 'install SNX' do
  cwd '/tmp/SNX'
  code %Q{
    chmod a+x *.sh
    ./snx_install_linux30.sh
  }
  creates '/usr/bin/snx'
end

template '/usr/local/bin/start_snx' do 
  source 'start_snx.erb'
  mode 0755
  variables :snx_server => node[:checkpoint][:snx_server], :snx_user => node[:checkpoint][:snx_user], :snx_password => node[:checkpoint][:snx_password]
end

execute 'start snx' do 
  user 'root'
  command '/usr/local/bin/start_snx'
  action :run
end