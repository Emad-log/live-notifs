import SwiftUI

@main
struct LiveNotifsDemoApp: App {
    @StateObject private var store = DemoStateStore.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try? await Task.sleep(for: .seconds(1.5))
                    await store.startDemo()
                }
        }
    }
}
