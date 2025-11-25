# CoreDNS Server Setup

This directory contains the CoreDNS configuration for server 192.168.0.37.

## Configuration

- **Server IP**: 192.168.0.37
- **DNS Port**: 5353 (to avoid conflict with systemd-resolved on port 53)
- **Domain**: test.svc
- **Record**: nginx.test.svc → 192.168.0.32

## Setup

On the server (192.168.0.37), run:

```bash
cd dns
docker-compose up -d
```

Check logs:
```bash
docker-compose logs -f
```

## Testing

Test from the server itself:
```bash
dig @localhost -p 5353 nginx.test.svc
nslookup -port=5353 nginx.test.svc localhost
```

Test from a client:
```bash
dig @192.168.0.37 -p 5353 nginx.test.svc
```

## Why Port 5353?

The server runs systemd-resolved which already uses port 53. CoreDNS uses port 5353 to avoid conflicts. Clients configured with systemd-resolved can specify DNS servers with custom ports using the `DNS=IP:PORT` format.

## Stopping

```bash
docker-compose down
```
