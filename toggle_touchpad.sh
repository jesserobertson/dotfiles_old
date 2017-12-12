#!/usr/bin/env bash

if synclient | grep --quiet 'TouchpadOff             = 0'; then
  synclient TouchpadOff=1
  notify-send Touchpad Disabled
else
  synclient TouchpadOff=0
  notify-send Touchpad Enabled
fi
