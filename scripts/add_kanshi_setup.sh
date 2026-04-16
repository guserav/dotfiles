#!/bin/bash

name=$1

if [ -z "$name" ]; then
    echo "Usage: $0 <name>"
    exit 1
fi

if swaymsg; then

    echo "Saving profile $name"

    echo -e "\nprofile $name {" | tee -a ~/.config/kanshi/config
    swaymsg -t get_outputs | \
      jq '.[] | "  output '"'"'\(.make) \(.model) \(.serial)'"'"' mode \(.current_mode.width)x\(.current_mode.height) position \(.rect.x),\(.rect.y)"' -r \
      | tee -a ~/.config/kanshi/config
    echo "}" | tee -a ~/.config/kanshi/config
fi
