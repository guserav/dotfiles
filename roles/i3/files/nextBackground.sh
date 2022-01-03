#! /usr/bin/env bash
[[ \$- == *i*   ]] || set -eu -o pipefail
IMAGE=`find ~/Bilder/Hintergrund/ -name \* -type f | shuf | head -n 3`
feh --bg-max $IMAGE
