#!/usr/bin/env bash

# Get memory info from /proc/meminfo (in kB)
mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_available=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

mem_used=$((mem_total - mem_available))
mem_percent=$(( (100 * mem_used) / mem_total ))

echo " ${mem_percent}%"
