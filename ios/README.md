# ActivityKit implementation

Add the files in `ios/LiveNotification` to an app target and a Widget Extension target. Set the Widget Extension deployment target to iOS 16.1 or later and enable Live Activities in the app target capabilities.

Call `ActivityPushHandler.start` from the app after the user starts tracking a flight. Keep the returned activity or find it through `Activity<FlightActivityAttributes>.activities` for local updates. For server updates, send the activity push token to your provider and use the payload shape in `push-payload.json`.

The widget renders the same state model as the browser demo: scheduled, disrupted, rerouted, monitoring, and resolved.