#! /usr/bin/env bash

for i in $(pactl list short sink-inputs | egrep -o '^[0-9]+')
do
    pactl move-sink-input $i @DEFAULT_SINK@
done
