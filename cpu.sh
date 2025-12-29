#!/usr/bin/env bash

# Read CPU usage from /proc/stat
read cpu a b c idle rest < /proc/stat
prev_idle=$idle
prev_total=$((a + b + c + idle))

sleep 0.5

read cpu a b c idle rest < /proc/stat
idle=$idle
total=$((a + b + c + idle))

diff_idle=$((idle - prev_idle))
diff_total=$((total - prev_total))

usage=$(( (100 * (diff_total - diff_idle)) / diff_total ))

echo " ${usage}%"
