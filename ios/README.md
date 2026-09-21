# ActivityKit implementation

A complete demo app + Widget Extension that plays the same state sequence as the browser demo on a real iOS lock screen, via a Live Activity.

## Project layout

- `project.yml` — XcodeGen spec. Run `xcodegen generate` in this directory to produce `LiveNotifsDemo.xcodeproj`.
- `LiveNotifsDemo/` — the app. Launches the demo automatically 1.5s after start.
- `FlightWidget/` — Widget Extension rendering the Live Activity on the lock screen and Dynamic Island.
- `Shared/` — `FlightActivityAttributes`, the scripted state sequence, and the App Intents behind the lock screen buttons.

## Recording the demo video

From the repo root on a Mac with Xcode 26+:

```
./ios/scripts/record-demo.sh
```

The script generates the project, boots an iPhone 17 Pro simulator, installs and launches the app, locks the screen, and records the sequence to `demo.mp4` in the repo root.

## State model

Same model as the browser demo: scheduled, disrupted, rerouted, monitoring, resolved. For server-driven updates, send the activity push token to your provider and use the payload shape in `push-payload.json`.
