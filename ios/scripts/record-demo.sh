#!/bin/bash
# Builds the LiveNotifsDemo app, boots an iPhone sim, locks the screen,
# and records the Live Activity sequence to demo.mp4.
# Requires: Xcode 26+, brew. Run from the repo root: ./ios/scripts/record-demo.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
IOS_DIR="$REPO_ROOT/ios"
SCHEME="LiveNotifsDemo"
BUNDLE_ID="dev.emad.livenotifs.LiveNotifsDemo"
DEVICE_NAME="LiveNotifs-Demo"
OUT="$REPO_ROOT/demo.mp4"

command -v xcodegen >/dev/null || brew install xcodegen

echo "== Generating Xcode project =="
(cd "$IOS_DIR" && xcodegen generate)

RUNTIME=$(xcrun simctl list runtimes -j | python3 -c '
import json, sys
rs = [r for r in json.load(sys.stdin)["runtimes"] if r["platform"] == "iOS" and r["isAvailable"]]
rs.sort(key=lambda r: [int(x) for x in r["version"].split(".")])
print(rs[-1]["identifier"])')
DEVICE_TYPE="com.apple.CoreSimulator.SimDeviceType.iPhone-17-Pro"

echo "== Creating/booting simulator (runtime $RUNTIME) =="
UDID=$(xcrun simctl create "$DEVICE_NAME" "$DEVICE_TYPE" "$RUNTIME")
xcrun simctl boot "$UDID" 2>/dev/null || true
open -a Simulator

echo "== Building =="
xcodebuild -project "$IOS_DIR/LiveNotifsDemo.xcodeproj" -scheme "$SCHEME" \
  -destination "id=$UDID" -derivedDataPath "$IOS_DIR/build" -quiet build

APP=$(find "$IOS_DIR/build/Build/Products" -name "$SCHEME.app" -path "*iphonesimulator*" | head -1)
xcrun simctl install "$UDID" "$APP"
xcrun simctl launch "$UDID" "$BUNDLE_ID"

echo "== Waiting for Live Activity to start =="
sleep 6

echo "== Recording =="
xcrun simctl io "$UDID" recordVideo "$OUT" &
REC_PID=$!
sleep 1

echo "== Locking screen =="
osascript -e 'tell application "Simulator" to activate' \
          -e 'tell application "System Events" to keystroke "l" using command down'

# scheduled(3) + disrupted(4) + rerouted(5) + monitoring(2.5) + resolved(4) + end(3) + buffer
sleep 24

kill -INT "$REC_PID"
wait "$REC_PID" || true

echo "== Done: $OUT =="
echo "To rerun: xcrun simctl shutdown $UDID && xcrun simctl delete $UDID"
