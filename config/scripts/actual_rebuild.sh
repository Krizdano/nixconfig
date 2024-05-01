#!/usr/bin/env sh


cd /persist/home/nixconfig; doas nixos-rebuild switch --flake .#$(hostname);
if [ $? -ne 0 ];
then touch /tmp/build_failed
else 
	rm -f /tmp/build_failed 
fi
