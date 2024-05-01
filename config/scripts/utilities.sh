#!/usr/bin/env bash

menu='dmenu -sync -i -p'
bookmark_file='~/nixconfig/config/scripts/bookmarks'
playlist='~/nixconfig/config/scripts/playlists'
screen='hyprctl dispatch dpms'
monitor='eDP-1'
music_player='mpv --shuffle --loop-playlist --title=playlist'

# Connect to already paired bluetooth devices ∆
connect_bluetooth() {
	device="$(bluetoothctl devices | $menu "Select Device" | awk -F ' ' '{print $2}')"
	notify-send "$(bluetoothctl connect $device | grep -i -m3 'connect' | tail -n1)"
} # ∇

# Open all my bookmarks ∆
my_bookmarks() {
	bookmark_menu=$(awk -F' ' '{print $1}' "$bookmark_file" | $menu "Bookmarks")
	wtype $(grep $bookmark_menu "$bookmark_file" | awk -F' ' '{print $2}')
} # ∇

# Add bookmarks ∆
add_bookmark () {
	url=$(dmenu -l 0 -p "Enter url")
	name=$(dmenu -l 0 -p "Enter name")

	if [[ "d" != "d$url" ]] && [[ "d" != "d$name" ]]; then
		echo "$name   $url" >> ~/nixconfig/config/scripts/bookmarks
		pushd ~/nixconfig;
		git add ~/nixconfig/config/scripts/bookmarks
		git commit -m "added a new bookmark"
		git push
		popd
	fi
} # ∇

# change default audio sink ∆
change_default_sink() {
	wpctl set-default "$(wpctl status | grep -A 3 Sinks | $menu "Sinks" | awk -F ' ' '{print $2}')"
} # ∇

# Toggle on/off laptop screen ∆
toggle_screen() {

	on_off_menu() {
		case "$1" in
		"") ;;
		Screenoff)
			$screen off $monitor
			;;
		Screenon)
			$screen on $monitor
			;;
		esac
	}
	options="Screenoff\nScreenon"
	on_off_menu "$(printf "%b" "$options" | sort | $menu "Screen")"
} # ∇

# Videos: Select videos from folders and play then in MPV ∆
play_videos() {
	find Videos/ -type f -printf "%f\n" | $menu "Videos" |
		xargs -I '{}' find ~/Videos/ -name {} | xargs mpv
} # ∇

# Playlist: Select and play my music playlists ∆
my_playlist() {
	playlist_menu=$(awk -F' ' '{print $1}' $playlist | $menu "Playlists")
	selected_playlist="grep $playlist_menu $playlist"
	notify-send "Playing Album: $($selected_playlist | awk -F' ' '{print $1}')"
	$music_player "$($selected_playlist | awk -F' ' '{print $2}')"
} # ∇

# Power menu ∆
power_menu() {
  chpower() {
    case "$1" in
      "")
      ;;
      Poweroff)
        exec systemctl poweroff
        ;;
      Reboot)
        exec systemctl reboot
        ;;
      Suspend)
        exec systemctl suspend
        ;;
      Hibernate)
        exec systemctl hibernate
        ;;
      lock)
        exec swaylock -c 000000
        ;;
    esac
  }

  options="Poweroff\nReboot\nHibernate\nSuspend\nlock"
  chpower "$(printf "%b" "$options" | sort | $menu "Power Menu")"
}
# ∇

# Play youtube video links in mpv using ytfzf ∆
youtube_mpv() {
	notify-send "fetching formats";
	wl-paste | xargs ytfzf -D -f -c url ;
	if [ $? -ne 0 ]; then
		notify-send "failed to play video";
		exit
	fi
	while pgrep "ytfzf" > /dev/null; do
		wait
	done
hyprctl dispatch workspace previous
} # ∇

# Battery status ∆
bat_level() {
	while true; do
		bat_lvl=$(cat /sys/class/power_supply/BAT1/capacity)
		bat_stat=$(cat /sys/class/power_supply/BAT1/status)

		if [[ $bat_lvl -le 30 && $bat_stat == "Discharging" ]]; then
			notify-send --urgency=CRITICAL "Battery Low" "Level: ${bat_lvl}%"
			sleep 300
		elif [[ $bat_lvl -ge 80 && $bat_stat == "Charging" ]]; then
			notify-send --urgency=CRITICAL "Unplug Your Charger" "Battery Level: ${bat_lvl}%"
			sleep 300
		else
			sleep 120
		fi
	done
} # ∇

# flip monitor ∆
flip_monitor () {
monitor_state=`hyprctl monitors | grep transform | tail -n 1 | awk '{print $2}'`

if [ $monitor_state -eq 0 ]; then
	hyprctl keyword monitor HDMI-A-1,transform,4
	hyprctl keyword monitor eDP-1,transform,4
else
	hyprctl keyword monitor HDMI-A-1,preferred,auto,1,transform,0
	hyprctl keyword monitor eDP-1,preferred,auto,1,transform,0
fi
} # ∇

case "$1" in
"") ;;
connect_bluetooth)
	"$@"
	exit
	;;
my_bookmarks)
	"$@"
	exit
	;;
add_bookmark)
	"$@"
	;;
change_default_sink)
	"$@"
	exit
	;;
toggle_screen)
	"$@"
	exit
	;;
play_videos)
	"$@"
	exit
	;;
my_playlist)
	"$@"
	exit
	;;
power_menu)
	"$@"
	exit
	;;
youtube_mpv)
	"$@"
	exit
	;;
bat_level)
	"$@"
	exit
	;;
flip_monitor)
	"$@"
	exit
	;;
*)
	echo "Unkown function: $1()"
	exit 2
	;;
esac

# vim: foldmethod=marker:fmr=∆,∇ :foldlevel=0 :foldlevelstart=0
