#!/bin/bash

API_KEY=" "
LAT=" "
LON=" "

# Get weather JSON
weather=$(curl -s "https://api.openweathermap.org/  ")

# Parse JSON
temp=$(echo "$weather" | jq ".main.temp" | xargs printf "%.0f")
feels=$(echo "$weather" | jq ".main.feels_like" | xargs printf "%.0f")
condition=$(echo "$weather" | jq -r ".weather[0].main")

# Default icon & color
icon=""
color="#7AA2F7"   # soft blue 
# Pick icon based on condition
case "$condition" in
    Clear) icon=""; color="#FDB813" ;;          # Sunny
    Clouds) icon=""; color="#A0AEC0" ;;         # Cloudy
    Rain) icon=""; color="#4A90E2" ;;           # Rain
    Drizzle) icon=""; color="#5FA7FF" ;;        # Light rain
    Thunderstorm) icon=""; color="#D69E2E" ;;   # Storm
    Snow) icon=""; color="#E0E7FF" ;;           # Snow
    Mist|Fog|Haze) icon=""; color="#CBD5E0" ;;  # Fog
    *) icon="" ;;              # Default cloud icon
esac

# Output to Polybar
echo "%{F$color}$icon%{F-} ${temp}°F (${feels}°F)"
