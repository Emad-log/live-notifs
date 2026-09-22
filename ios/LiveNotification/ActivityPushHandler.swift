import ActivityKit

struct ActivityPushHandler {
    static func start(flightNumber: String, origin: String, destination: String) async throws {
        let attributes = FlightActivityAttributes(flightNumber: flightNumber, origin: origin, destination: destination)
        let state = FlightActivityAttributes.ContentState(
            phase: .scheduled,
            title: "Flight \(flightNumber) is on time",
            detail: "Boarding begins at 9:55 at gate B12.",
            gate: "B12",
            departure: "10:00"
        )
        let content = ActivityContent(state: state, staleDate: Date().addingTimeInterval(3600))
        _ = try Activity.request(attributes: attributes, content: content, pushType: .token)
    }

    static func update(_ activity: Activity<FlightActivityAttributes>, state: FlightActivityAttributes.ContentState) async {
        let content = ActivityContent(state: state, staleDate: Date().addingTimeInterval(3600))
        await activity.update(content)
    }

    static func end(_ activity: Activity<FlightActivityAttributes>, state: FlightActivityAttributes.ContentState) async {
        let content = ActivityContent(state: state, staleDate: nil)
        await activity.end(content, dismissalPolicy: .default)
    }
}
