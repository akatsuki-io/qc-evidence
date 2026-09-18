#!/bin/sh
# usage: shot.sh <before|after> <name>   — screenshot the booted iPad sim
UDID=AC5E78B0-25E1-47ED-92FA-337D9388AFD9
xcrun simctl io "$UDID" screenshot --type=png "/Users/nhduc/orca/workspaces/project/ipad-layout-sweep/qc-evidence/ipad-sweep/$1/$2.png" >/dev/null && echo "$1/$2.png"
