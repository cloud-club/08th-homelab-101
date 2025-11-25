## DNS Server (CoreDNS)

```bash
[INFO] plugin/reload: Running configuration SHA512 = 771fea722f7ee97ee918993120ef02389a0043c6607f2f9b29fbc61d569f4977a6cae25209ed9bb4a2d5e7349026b564fb3e26b64bc2d54b7efa996538bd4d2b
CoreDNS-1.13.1
linux/amd64, go1.25.2, 1db4568
[INFO] 192.168.0.38:59311 - 33184 "A IN nginx.test.svc. udp 32 false 512" NOERROR qr,aa,rd 95 0.000185075s
[INFO] 192.168.0.38:50022 - 55458 "AAAA IN nginx.test.svc. udp 32 false 512" NOERROR qr,aa,rd 110 0.000083972s
[INFO] 192.168.0.38:35572 - 17944 "AAAA IN nginx.test.svc. udp 43 false 1472" NOERROR qr,aa,rd 110 0.000130373s
[INFO] 192.168.0.38:56318 - 42785 "A IN nginx.test.svc. udp 43 false 1472" NOERROR qr,aa,rd 95 0.00019365s
[INFO] 192.168.0.38:57816 - 43994 "A IN naver.com. udp 38 false 1472" NOERROR qr,rd,ra 127 0.058784143s
[INFO] 192.168.0.38:35330 - 21184 "AAAA IN naver.com. udp 38 false 1472" NOERROR qr,rd,ra 104 0.062504327s
[INFO] 192.168.0.38:56555 - 34767 "AAAA IN ntp.ubuntu.com. udp 43 false 1472" NOERROR qr,rd,ra 158 0.058159009s
[INFO] 192.168.0.38:36719 - 14342 "A IN ntp.ubuntu.com. udp 43 false 1472" NOERROR qr,rd,ra 152 0.060816488s
[INFO] 192.168.0.38:35734 - 29690 "A IN api.snapcraft.io. udp 45 false 1472" NOERROR qr,rd,ra 162 0.038744321s
[INFO] 192.168.0.38:50482 - 51016 "AAAA IN api.snapcraft.io. udp 45 false 1472" NOERROR qr,rd,ra 210 0.061416185s
```


## Client


```bash
ubuntu@client:~/client$ sudo ./setup-dns.sh
Configuring DNS server to 192.168.0.37:5353...
Detected systemd-resolved
DNS configured via systemd-resolved

Current DNS configuration:
# This is /run/systemd/resolve/stub-resolv.conf managed by man:systemd-resolved(8).
# Do not edit.
#
# This file might be symlinked as /etc/resolv.conf. If you're looking at
# /etc/resolv.conf and seeing this text, you have followed the symlink.
#
# This is a dynamic resolv.conf file for connecting local clients to the
# internal DNS stub resolver of systemd-resolved. This file lists all
# configured search domains.
#
# Run "resolvectl status" to see details about the uplink DNS servers
# currently in use.
#
# Third party programs should typically not access this file directly, but only
# through the symlink at /etc/resolv.conf. To manage man:resolv.conf(5) in a
# different way, replace this symlink by a static file or a different symlink.
#
# See man:systemd-resolved.service(8) for details about the supported modes of
# operation for /etc/resolv.conf.

nameserver 127.0.0.53
options edns0 trust-ad
search .

Testing DNS resolution for nginx.test.svc...
Server:         192.168.0.37
Address:        192.168.0.37#5353

Name:   nginx.test.svc
Address: 192.168.0.32

ubuntu@client:~/client$ curl nginx.test.svc
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
ubuntu@client:~/client$ curl naver.com
<html>
<head><title>301 Moved Permanently</title></head>
<body>
<center><h1>301 Moved Permanently</h1></center>
<hr><center>nginx</center>
</body>
</html>
```
