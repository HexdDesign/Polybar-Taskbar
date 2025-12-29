#!/bin/bash

ICON="󰮯"  # pacman/updates icon

updates=$(checkupdates 2>/dev/null | wc -l)

echo " $ICON $updates "
