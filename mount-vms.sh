#!/usr/bin/env bash

set -euo pipefail

UUID="8b2ead6b-c9bd-4c03-bcd8-2caab33480f6"

sudo cryptsetup open /dev/disk/by-uuid/"$UUID" cryptvms
sleep 1
sudo mount /dev/mapper/cryptvms /vms -o noatime,nosuid,noexec,nodev

unset UUID
