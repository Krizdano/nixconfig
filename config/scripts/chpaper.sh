#!/usr/bin/env bash

wpname=`shuf -i 1-13 -n 1`
wallpaper_url='https://raw.githubusercontent.com/Krizdano/wallpapers/main/images/'$wpname'.png'
wallpaper='/tmp/wallpaper.png'
backup_wallpaper='Pictures/.backup_wallpaper.png'

if ping -q -w 1 -c 1 https://raw.githubusercontent.com > /dev/null; then
	curl --silent --output $wallpaper $wallpaper_url 
	cp $wallpaper $backup_wallpaper
	# swww query || swww init
	# swww img --transition-type random --transition-duration 1 $wallpaper
	swaybg -i $wallpaper
else
	# swww query || swww init
	# swww img --transition-type random --transition-duration 1 $backup_wallpaper
	swaybg -i $backup_wallpaper
fi
