#!/bin/bash
syslog -s -l notice MOVE STICKY
# Get current workspace
current_workspace=$1
syslog -s -l notice MOVE STICKY to $current_workspace
# Move PiP windows to current workspace (handles both "Picture-in-Picture" and "Picture in Picture")
aerospace list-windows --all | grep -E "(Outlook.+Erinnerung|Picture.in.Picture)" | awk '{print $1}' | while read window_id; do
    if [ -n "$window_id" ]; then
        aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
    fi
done

