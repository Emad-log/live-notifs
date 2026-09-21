import ActivityKit
import AppIntents

// Runs in whichever process hosts the button, so it updates the activity directly
// instead of touching app-only state.
struct RebookIntent: AppIntent {
    static var title: LocalizedStringResource = "Rebook via DEN"

    func perform() async throws -> some IntentResult {
        guard let activity = Activity<FlightActivityAttributes>.activities.first else { return .result() }
        await activity.update(ActivityContent(state: DemoStates.monitoring, staleDate: Date().addingTimeInterval(3600)))
        try? await Task.sleep(for: .seconds(1.5))
        await activity.update(ActivityContent(state: DemoStates.resolved, staleDate: Date().addingTimeInterval(3600)))
        try? await Task.sleep(for: .seconds(3))
        await activity.end(ActivityContent(state: DemoStates.resolved, staleDate: nil), dismissalPolicy: .after(Date().addingTimeInterval(3)))
        return .result()
    }
}
