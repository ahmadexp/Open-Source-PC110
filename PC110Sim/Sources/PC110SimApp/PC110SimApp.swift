import SwiftUI

@main
struct PC110SimApp: App {
    @StateObject private var host = EmulatorHost()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(host)
                .onAppear {
                    host.start()
                }
        }
        .windowStyle(.titleBar)
    }
}
