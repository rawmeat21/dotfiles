#!/bin/bash
vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
percent=$(echo "$vol_raw" | awk '{printf "%d", $2 * 100}')
muted=$(echo "$vol_raw" | grep -o MUTED)

filled=$(( percent / 10 ))
[ "$filled" -gt 10 ] && filled=10
empty=$(( 10 - filled ))

bar=""
for i in $(seq 1 $filled); do bar="${bar}▇"; done
for i in $(seq 1 $empty); do bar="${bar}▁"; done

if [ "$muted" == "MUTED" ]; then
    echo "󰝟 $bar"
else
    echo "󰕾 $bar $percent%"
fi
