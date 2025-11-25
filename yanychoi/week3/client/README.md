# DNS Client Configuration

This directory contains a script to configure client machines to use the CoreDNS server at `192.168.0.37:5353`.

## Usage

On the client machine, run:

```bash
sudo ./setup-dns.sh
```

This script will:
- Detect your system's DNS management method (systemd-resolved, resolvconf, or direct /etc/resolv.conf)
- Configure `192.168.0.37:5353` as the primary DNS server
- Add fallback DNS servers (8.8.8.8, 8.8.4.4)
- Test DNS resolution for `nginx.test.svc`

## Requirements

- Root/sudo access
- Linux-based system
- Network connectivity to 192.168.0.37 port 5353

## Reverting Changes

### For systemd-resolved systems:
```bash
sudo rm /etc/systemd/resolved.conf.d/custom-dns.conf
sudo systemctl restart systemd-resolved
```

### For resolvconf systems:
```bash
sudo rm /etc/resolvconf/resolv.conf.d/head
sudo resolvconf -u
```

### For direct /etc/resolv.conf:
```bash
sudo chattr -i /etc/resolv.conf
sudo cp /etc/resolv.conf.backup /etc/resolv.conf
```
