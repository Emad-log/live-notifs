import ActivityKit

@MainActor
final class DemoStateStore: ObservableObject {
    static let shared = DemoStateStore()

    private var activity: Activity<FlightActivityAttributes>?
    private var timeline: Task<Void, Never>?

    func startDemo() async {
        guard activity == nil else { return }
        let attrs = FlightActivityAttributes(flightNumber: "UA 837", origin: "SFO", destination: "NRT")
        do {
            let a = try Activity.request(
                attributes: attrs,
                content: ActivityContent(state: DemoStates.scheduled, staleDate: Date().addingTimeInterval(3600))
            )
            activity = a
            timeline = Task { await self.play() }
        } catch {
            print("Live Activity request failed: \(error)")
        }
    }

    private func play() async {
        await pause(3.0)
        await update(DemoStates.disrupted)
        await pause(4.0)
        await update(DemoStates.rerouted)
        await pause(5.0)
        await update(DemoStates.monitoring)
        await pause(2.5)
        await update(DemoStates.resolved)
        await pause(4.0)
        await activity?.end(ActivityContent(state: DemoStates.resolved, staleDate: nil), dismissalPolicy: .after(Date().addingTimeInterval(3)))
    }

    private func update(_ state: FlightActivityAttributes.ContentState) async {
        guard !Task.isCancelled else { return }
        await activity?.update(ActivityContent(state: state, staleDate: Date().addingTimeInterval(3600)))
    }

    private func pause(_ seconds: Double) async {
        try? await Task.sleep(for: .seconds(seconds))
    }
}
