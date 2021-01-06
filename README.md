Troglodyne-API cPanel & WHM Plugin
==================================

Common code for Troglodyne Plugins

If you like this plugin, consider sending a a few dollars this way:
https://paypal.me/troglodyne

INSTALLING
----------
Two methods exist for accomplishing installs.
### End user (stable) installs:
* Add the *Troglodyne* yum repository to `/etc/yum.repos.d/troglodyne`:
```
[troglodyne]
name=Troglodyne Internet Widgets
mirrorlist=https://repos.troglodyne.net/CentOS/7/$basearch/mirrorlist
enabled=1
```
* Install the RPM:
`yum install Troglodyne-API`
* To uninstall:
`yum remove Troglodyne-API`

This way whenever I make a new release you'll get it via `yum update` without any real hassle.

### Developer install:
* Clone the repository using the link in github:
`git clone https://github.com/Troglodyne-Internet-Widgets/troglodyne-api.git`
* Move into the directory it cloned this to:
`cd troglodyne-api`
* Run the makefile:
`make`
* To uninstall:
`make uninstall`

What do I do if I need help?
----------------------------
Hop on the Matrix Chat server for troglodyne. Instructions here: https://chat.troglodyne.net.
If you can't find the answers you need, feel free to drop an issue in the tracker.

...and last of all, see license terms.
