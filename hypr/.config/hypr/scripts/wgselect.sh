#!/bin/bash

WG_DIR="/etc/wireguard"

# Get currently active WireGuard interfaces
active=$(wg show interfaces 2>/dev/null)

# Build menu entries
entries=""
for conf in $(sudo find "$WG_DIR" -maxdepth 1 -name "*.conf"); do
    name=$(basename "$conf" .conf)
    if echo "$active" | grep -qw "$name"; then
        entries+="  $name (active)\n"
    else
        entries+="$name\n"
    fi
done

# Add disconnect option if any active
if [ -n "$active" ]; then
    entries+="disconnect all\n"
fi

# Show tofi picker
choice=$(printf "%b" "$entries" | tofi --prompt-text "WireGuard: ")

[ -z "$choice" ] && exit 0

if [ "$choice" = "disconnect all" ]; then
    for iface in $active; do
        sudo wg-quick down "$iface"
    done
    nmcli networking off && nmcli networking on
elif [[ "$choice" == *"(active)"* ]]; then
    # Strip the " (active)" suffix and toggle off
    name=$(echo "$choice" | sed 's/ (active)//' | xargs)
    sudo wg-quick down "$name"
    nmcli networking off && nmcli networking on
else
    name=$(echo "$choice" | xargs)
    sudo resolvconf -u
    sudo wg-quick up "$WG_DIR/$name.conf"
fi
