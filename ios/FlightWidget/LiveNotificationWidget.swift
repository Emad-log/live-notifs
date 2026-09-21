import ActivityKit
import SwiftUI
import WidgetKit

struct LiveNotificationWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlightActivityAttributes.self) { context in
            LockScreenView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Label(context.attributes.flightNumber, systemImage: "airplane")
                        .font(.caption.bold())
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Gate \(context.state.gate)")
                        .font(.caption.bold())
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(context.state.title)
                        .font(.caption.bold())
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.detail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } compactLeading: {
                Image(systemName: "airplane")
            } compactTrailing: {
                Text(context.state.gate)
                    .font(.caption2.bold())
            } minimal: {
                Image(systemName: "airplane")
            }
        }
    }
}

private struct LockScreenView: View {
    let context: ActivityViewContext<FlightActivityAttributes>

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: "airplane.circle.fill")
                    .foregroundStyle(.white, Color(red: 0.1, green: 0.45, blue: 0.85))
                Text("UNITED")
                    .font(.caption.weight(.semibold))
                    .tracking(1)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("now")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }

            Text(eyebrow)
                .font(.caption2.weight(.semibold))
                .tracking(1.2)
                .foregroundStyle(eyebrowColor)

            Text("\(context.attributes.flightNumber) · \(context.attributes.origin) → \(context.attributes.destination)")
                .font(.headline)

            Text(context.state.detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack(spacing: 10) {
                Text(context.attributes.origin)
                Image(systemName: "arrow.right")
                Text(context.attributes.destination)
                Spacer()
                Text(context.state.title)
                    .foregroundStyle(statusColor)
            }
            .font(.subheadline.bold())
            .padding(.top, 4)

            if context.state.phase == .rerouted {
                HStack(spacing: 8) {
                    Button(intent: RebookIntent()) {
                        Text("Rebook via DEN")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)

                    Button(intent: KeepCurrentIntent()) {
                        Text("Keep Current")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.top, 4)
            }
        }
        .padding()
    }

    private var eyebrow: String {
        switch context.state.phase {
        case .disrupted: return "TRAVEL ALERT"
        case .rerouted, .monitoring, .resolved: return "AI ASSISTANT"
        case .scheduled: return "FLIGHT STATUS"
        }
    }

    private var eyebrowColor: Color {
        switch context.state.phase {
        case .disrupted: return .orange
        case .rerouted, .monitoring, .resolved: return .purple
        case .scheduled: return .secondary
        }
    }

    private var statusColor: Color {
        switch context.state.phase {
        case .disrupted: return .orange
        case .resolved: return .green
        default: return .primary
        }
    }
}
