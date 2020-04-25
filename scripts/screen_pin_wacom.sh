#! /usr/bin/env bash

MAIN=$(xrandr --listactivemonitors | grep "+\*" | grep -oE "[a-zA-Z]+-[0-9]+\$")
echo "Pinning to $MAIN"
for i in $(xsetwacom --list devices | grep -oE "[0-9]+")
do
    xsetwacom --set "$i" MapToOutput $MAIN
done
