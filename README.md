# Live Notification Agent

A small interactive prototype showing a push notification as a stateful agent thread.

Open `index.html` in a browser. Choose a state in the timeline or use the inline action inside the notification. The same thread carries flight context forward through disruption, rerouting, monitoring, and resolution.

The prototype uses plain HTML, CSS, and JavaScript so the interaction stays easy to inspect.

## ActivityKit

`ios/LiveNotification` contains a drop-in ActivityKit model, Widget Extension, Dynamic Island layout, and push handler. `ios/push-payload.json` shows the server payload for a state update. See `ios/README.md` for Xcode setup.

The Swift implementation uses the same state model as the browser demo: scheduled, disrupted, rerouted, monitoring, and resolved.