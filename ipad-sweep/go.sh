#!/bin/sh
# usage: go.sh <before|after> <name> <route>  — deep-link the iPad dev client to a route, confirm the "Open in FillR?" alert, screenshot
UDID=AC5E78B0-25E1-47ED-92FA-337D9388AFD9
D=/Users/nhduc/orca/workspaces/project/ipad-layout-sweep/qc-evidence/ipad-sweep
xcrun simctl openurl "$UDID" "fillrv2://$3" && sleep 2
cat > /tmp/ipad-open.yaml <<Y
appId: io.fillr.mobile.v2
---
- tapOn:
    point: "${OPEN_PT:-59%,51%}"
Y
maestro --device "$UDID" test /tmp/ipad-open.yaml >/dev/null 2>&1
sleep "${WAIT:-4}"
"$D/shot.sh" "$1" "$2"
