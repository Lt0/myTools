# Description
LXDE descktop based on ubuntu 18.04 and running in container. Support VNC/RPD client and browser.

# Connect
Default access password is lightime, you can change it by VNC_PASSWD environment variable.

## Browser
Access IP:Port in browser directly.

Default IP should be host IP, Port is 6901, access password is lightime

e.g: 192.168.0.5:6901


## VNC client
You can also access the remote desktop by VNC client(e.g: vncviewer)

Server: IP:Port

 Default IP should be host IP, Port is 5901
 
Encription: "Let VNC Server choose"

Default access password is lightime

## RPD
If you don't have these client but you are using windows, you can access this remote desktop with windows integrated RPD remote desktop client.

1. Open your windows remote desktop client

2. Input your remote desktop IP to Compute field, defualt should be host IP

3. Click connect

4. Accept insecurity connection

5. You will see a login pannel which from xrpd now. Session: vnc-any, IP: 127.0.0.1, port: 5901, password: lightime (by default), and then click OK

# Todo

- support encrypt transfer
- support clipboard share with vnc client
- support clipboard share with client for web

