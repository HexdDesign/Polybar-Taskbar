#!/usr/bin/env bash

BATTERY="BAT1"
POWER_SUPPLY="/sys/class/power_supply/$BATTERY"

CAPACITY_PATH="$POWER_SUPPLY/capacity"
STATUS_PATH="$POWER_SUPPLY/status"

# Exit cleanly if battery doesn't exist
[[ -r "$CAPACITY_PATH" && -r "$STATUS_PATH" ]] || exit 0

capacity=$(<"$CAPACITY_PATH")
status=$(<"$STATUS_PATH")

# Nerd Font icons
ICON_FULL="󰁹"
ICON_0="󰁺"
ICON_1="󰁻"
ICON_2="󰁼"
ICON_3="󰁽"
ICON_4="󰁾"
ICON_5="󰁿"
ICON_6="󰂀"

CHARGE_ICONS=(󰢟 󰢜 󰂆 󰂇 󰂈)

# Colors
GREEN="%{F#98c379}"
YELLOW="%{F#e5c07b}"
ORANGE="%{F#d19a66}"
RED="%{F#e06c75}"
BLUE="%{F#61afef}"
RESET="%{F-}"

# Charging animation state
FRAME_FILE="/tmp/polybar_battery_frame"
frame=0
[[ -f "$FRAME_FILE" ]] && frame=$(<"$FRAME_FILE")

((frame = (frame + 1) % ${#CHARGE_ICONS[@]}))
echo "$frame" > "$FRAME_FILE"

if [[ "$status" == "Charging" ]]; then
    icon="${CHARGE_ICONS[$frame]}"
    color=$BLUE
else
    if (( capacity >= 90 )); then
        icon=$ICON_FULL
        color=$BLUE
    elif (( capacity >= 70 )); then
        icon=$ICON_6
        color=$GREEN
    elif (( capacity >= 50 )); then
        icon=$ICON_5
        color=$GREEN
    elif (( capacity >= 30 )); then
        icon=$ICON_3
        color=$YELLOW
    elif (( capacity >= 15 )); then
        icon=$ICON_2
        color=$ORANGE
    else
        icon=$ICON_0
        color=$RED
    fi
fi

# Hide when full & plugged in
if [[ "$status" == "Charging" && "$capacity" -ge 98 ]]; then
    exit 0
fi

echo "${color}${icon} ${capacity}%${RESET}"

