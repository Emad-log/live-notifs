import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "airplane")
                    .font(.system(size: 44))
                    .foregroundStyle(.white)
                Text("UA 837 · SFO → NRT")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                Text("Live demo running. Lock your screen.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ContentView()
}
