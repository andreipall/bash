#!/bin/bash
# This Bash script adds partitions to fstab, by Andrei Pall

if [ $UID -ne 0 ]; then
    echo "ERROR: Run as root user..."
    exit 1
fi

path="/mnt/Date"

# Check if the mount point directory exists and create it if it doesn't
if [ ! -d "$path" ]; then
    mkdir -p "$path"
    partition_uuid=$( blkid | grep -i 'LABEL="Date"' | awk -F '"' '{print $4}' )
    echo "UUID=${partition_uuid} ${path}       ext4    defaults  0      2" >> /etc/fstab
    mount -a
    systemctl daemon-reload
    echo "The partition ${path} has been mounted."
else
    echo "The partition ${path} is already mounted."
fi