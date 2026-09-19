import ActivityKit
import SwiftUI
import WidgetKit

struct LiveNotificationWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlightActivityAttributes.self) { context in
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(context.attributes.flightNumber).font(.headline)
                    Spacer()
                    Text(context.state.phase.rawValue.capitalized).font(.caption)
                }
                Text(context.state.title).font(.subheadline.bold())
                Text(context.state.detail).font(.caption).foregroundStyle(.secondary)
                HStack {
                    Text(context.attributes.origin)
                    Image(systemName: "arrow.right")
                    Text(context.attributes.destination)
                    Spacer()
                    Text(context.state.departure)
                }.font(.caption.bold())
            }
            .padding()
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(.white)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.attributes.flightNumber).font(.headline)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.gate).font(.caption.bold())
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(context.state.title).font(.caption.bold())
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.detail).font(.caption)
                }
            } compactLeading: {
                Text(context.attributes.flightNumber)
            } compactTrailing: {
                Text(context.state.gate)
            } minimal: {
                Image(systemName: "airplane")
            }
        }
    }
}
