import SwiftUI

@main
struct ESPOpenerApp: App {
    @StateObject private var settings = AppSettings()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(settings)
        }
    }
}
