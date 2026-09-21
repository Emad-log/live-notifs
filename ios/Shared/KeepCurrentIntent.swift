import AppIntents

struct KeepCurrentIntent: AppIntent {
    static var title: LocalizedStringResource = "Keep Current"

    func perform() async throws -> some IntentResult {
        .result()
    }
}
