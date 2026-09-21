import Foundation

enum DemoStates {
    typealias State = FlightActivityAttributes.ContentState

    static let scheduled = State(phase: .scheduled, title: "On time", detail: "Gate 82 · Departs 11:05 AM", gate: "82", departure: "11:05 AM")
    static let disrupted = State(phase: .disrupted, title: "Delayed 45m", detail: "Connection in NRT at risk", gate: "82", departure: "11:50 AM")
    static let rerouted = State(phase: .rerouted, title: "Found a seat on UA 1492 via DEN", detail: "Arrives on time. Rebook now?", gate: "C18", departure: "12:20 PM")
    static let monitoring = State(phase: .monitoring, title: "Securing seat on UA 1492…", detail: "Hold on", gate: "C18", departure: "12:20 PM")
    static let resolved = State(phase: .resolved, title: "Confirmed · UA 1492 via DEN", detail: "Gate C18 · Seat 14A", gate: "C18", departure: "12:20 PM")
}
