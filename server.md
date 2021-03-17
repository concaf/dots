# RHEL server

- To sync the time via NTP, make sure the `chronyd` service is running and enabled. Restart it and the time should be synced.
- In case of dual boot, to make sure that Windows shows up in Grub, install `ntfs-3g` and rebuild grub - https://unix.stackexchange.com/a/591008
