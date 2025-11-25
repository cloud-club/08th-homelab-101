#!/bin/bash

# Script to configure DNS server to 192.168.0.37:5353

DNS_SERVER="192.168.0.37"
DNS_PORT="5353"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

echo "Configuring DNS server to ${DNS_SERVER}:${DNS_PORT}..."

# Detect if system uses systemd-resolved
if systemctl is-active --quiet systemd-resolved; then
    echo "Detected systemd-resolved"

    # Create resolved.conf.d directory if it doesn't exist
    mkdir -p /etc/systemd/resolved.conf.d

    # Configure systemd-resolved
    cat > /etc/systemd/resolved.conf.d/custom-dns.conf <<EOF
[Resolve]
DNS=${DNS_SERVER}:${DNS_PORT}
Domains=~test.svc
EOF

    # Restart systemd-resolved
    systemctl restart systemd-resolved

    echo "DNS configured via systemd-resolved"

elif command -v resolvconf &> /dev/null; then
    echo "Detected resolvconf"

    # Add to head file so it takes precedence
    echo "nameserver ${DNS_SERVER}" > /etc/resolvconf/resolv.conf.d/head

    # Update resolv.conf
    resolvconf -u

    echo "DNS configured via resolvconf"

else
    echo "Using direct /etc/resolv.conf configuration"

    # Backup existing resolv.conf
    cp /etc/resolv.conf /etc/resolv.conf.backup

    # Create new resolv.conf
    cat > /etc/resolv.conf <<EOF
# Custom DNS configuration
nameserver ${DNS_SERVER}
# Fallback DNS servers
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

    # Make it immutable to prevent overwriting
    chattr +i /etc/resolv.conf 2>/dev/null || true

    echo "DNS configured via /etc/resolv.conf"
fi

echo ""
echo "Current DNS configuration:"
cat /etc/resolv.conf
echo ""
echo "Testing DNS resolution for nginx.test.svc..."
nslookup -port=${DNS_PORT} nginx.test.svc ${DNS_SERVER} || dig @${DNS_SERVER} -p ${DNS_PORT} nginx.test.svc
