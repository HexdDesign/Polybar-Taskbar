LOCKFILE=/tmp/polybar-rescale.lock

if [ -e "$LOCKFILE" ]; then
  exit 0
fi

touch "$LOCKFILE"
trap "rm -f $LOCKFILE" EXIT

#!/usr/bin/env bash
# Kill existing Polybar instances
killall -q polybar

# Wait until processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

# Launch Polybar
polybar main &
