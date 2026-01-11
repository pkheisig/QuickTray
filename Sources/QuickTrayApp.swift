import SwiftUI

@main
struct QuickTrayApp: App {
    var body: some Scene {
        MenuBarExtra("QuickTray", systemImage: "tray.full.fill") {
            ContentView()
        }
        .menuBarExtraStyle(.window) // Allows rich interactive content (macOS 13+)
    }
}
