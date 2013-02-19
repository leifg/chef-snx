# Description

This recipe installs the SSL Network Extender from Checkpoint. This is not an official

## Prequisits

As it is not possible to automatically download the binary for SSL Network Extender you need to add the install file to /mnt/share before you run the recipe. You can download the install file frome [here](https://supportcenter.checkpoint.com/supportcenter/portal/user/anon/page/default.psml/media-type/html?action=portlets.DCFileAction&eventSubmit_doGetdcdetails=&fileid=8993)

Alternatively you can specifiy another path (or filename) in the attributes.

## Recipes

### default

(Currently) the only recipe to install SNX. It also starts the SNX service and creates the network interface (tunsnx). When the connection is disconnected you can restart it via `start_snx`