# jka-server

## Automatically install Jedi Academy servers with VPN blocking capabilities on Virtual Machines.

### Hello, and welcome.

**Note** This project is a WIP, but has been used for some time to run JKL servers on various cloud platforms for more than a year. Automatic setup of VPNMonitor coming soon.

You might like this if you:

1. Are interested in running JKA servers in the cloud.
0. Need to install one of the following servers:
   - Vanilla Base
   - Yberion Proxy Base
0. Want to block VPN users on your servers.
0. Want your JKA server to start automatically on boot.
0. Want to run your server under a non-root user.
0. And more!

### Instructions

**Note** I usually use a recent version of Ubuntu server.

### Prepare machine to host any JKA server.

1. Clone this repository onto your server.
0. cd `jka-server/scripts`
0. `chmod +x install.sh`
0. `sudo ./install.sh`
0. `cd ..`

### Download asset files (pk3 files) from somewhere.

**Note** The important thing about this part of the procedure is that you put the asset pk3 files into the `assets` directory. I host mine somewhere in a tgz file and use wget to download them to the server, so that's what I'll show here.

1. cd `assets`
0. wget `assets-from-some-url`
0. `tar -xf name-of-assets-archive`
0. `cd ..`

### Now, a choice:
- Vanilla Base
  - `cd servers/vanilla`
- Yberion Proxy Base
  - `cd servers/yberion-proxy`

### Edit server.cfg
There's a server.cfg file in the current directory. You can either change it here, or change it post-install at `/home/jka-server/server/base/server.cfg.`

### Install the server:
1. `chmod +x install.sh`
0. `sudo ./install.sh`

### Wrapping up
If all went, well, there should be an unlisted JKA server running on your machine. If your server / cloud firewall settings are setup to allow UDP traffic to instances on port 29070, then you should be able to connect to your server at your-server-ip:29070.

- Restart server: `sudo systemctl restart jka-server`
- Stop server: `sudo systemctl stop jka-server`
- Start server `sudo systemctl start jka-server`

### TODO:
- Automatic setup of VPNMonitor
- Automatic setup of cronjobs to restart server daily