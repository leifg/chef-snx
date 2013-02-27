# snx cookbook

As it is not possible to automatically download the binary for SSL Network Extender you need to add the install file to /mnt/share before you run the recipe. You can download the install file frome [here](https://supportcenter.checkpoint.com/supportcenter/portal/user/anon/page/default.psml/media-type/html?action=portlets.DCFileAction&eventSubmit_doGetdcdetails=&fileid=8993)

# Requirements

# Usage

# Attributes

  - `node[:snx][:install_source]` - folder where snx install file is stored
  - `node[:snx][:install_filename]` - filename of snx install file
  - `node[:snx][:server]` - server to which to connect
  - `node[:snx][:user]` - user for snx endpoint
  - `node[:snx][:password]` - password for snx endpoint

# Recipes

## default

(Currently) the only recipe to install SNX. It also starts the SNX service and creates the network interface (tunsnx). When the connection is disconnected you can restart it via `start_snx`

# Author

Author:: Leif Gensert (leif@propertybase.com)