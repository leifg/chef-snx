general_packages = %w{expect}

if node['platform'] == 'centos'
  (%w{xterm.x86_64 elfutils-libelf.i686 libX11.i686 libaudit.so.1 cracklib.x86_64 db4.x86_64 libselinux.x86_64 pam.i686 compat-libstdc++-33.i686} + general_packages).each do | pkg |
    yum_package pkg do
      action :install
    end
  end
else
  (%w{ia32-libs libpam0g:i386 libx11-6:i386 libstdc++5:i386} + general_packages).each do | pkg |
    package pkg do
      action :install
    end
  end
end

execute 'copy checkpoint installation file' do
  command "cp #{node[:snx][:install_source]}/#{node[:snx][:install_filename]} /tmp/"
  creates "/tmp/#{node[:snx][:install_filename]}"
end

bash 'extract installation tar' do
  cwd '/tmp'
  code %Q{
    mkdir -p SNX
    tar xzf #{node[:snx][:install_filename]} -C SNX
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

template '/usr/local/bin/start-snx' do
  source 'start_snx.erb'
  mode 0755
  variables :server => node[:snx][:server], :user => node[:snx][:user], :password => node[:snx][:password]
end

execute 'start snx' do 
  user 'root'
  command '/usr/local/bin/start-snx'
  action :run
end