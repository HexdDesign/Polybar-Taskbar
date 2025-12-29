#!/usr/bin/env bash

options="󰍃  Lock
󰌾  Logout
󰤄  Suspend
󰜉  Reboot
󰐥  Poweroff"

chosen=$(printf "%s\n" "$options" | rofi -dmenu \
  -no-custom \
  -theme ~/.config/rofi/powermenu.rasi)

case "$chosen" in
  *Lock) i3lock -c 000000 ;;
  *Logout) i3-msg exit ;;
  *Suspend) systemctl suspend ;;
  *Reboot) systemctl reboot ;;
  *Poweroff) systemctl poweroff ;;
esac
