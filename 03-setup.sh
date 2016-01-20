#!/usr/bin/env bash

# Start httpd
sudo systemctl start httpd
# Start cobbler
sudo systemctl start cobblerd

# Calls to Cobbler need cobbler to be running (#captainobvious).
# This small snippet will ask for cobbler status # three times.
# Once the service is confirmed to be up, two calls will be sent to Cobbler:
# 1. Install the boot loaders
# 2. Save changes

for i in 1 2 3
do
  sudo cobbler status > /dev/null
  if [ $? -eq 0 ]
  then
    # Install cobbler bootloaders
    sudo cobbler get-loaders

    # Apply changes to Cobbler config
    sudo cobbler sync
    break
  else
    echo "Waiting for Cobbler to start. Attempt #$i"
    sleep 1
    continue
  fi
done
