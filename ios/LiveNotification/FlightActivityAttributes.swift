import ActivityKit

struct FlightActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var phase: Phase
        var title: String
        var detail: String
        var gate: String
        var departure: String
    }

    enum Phase: String, Codable, Hashable {
        case scheduled
        case disrupted
        case rerouted
        case monitoring
        case resolved
    }

    var flightNumber: String
    var origin: String
    var destination: String
}
