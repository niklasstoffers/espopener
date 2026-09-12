import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settings: AppSettings

    var body: some View {
        Form {
            Section("General") {
                Toggle("Auto Unlock", isOn: $settings.autoUnlock)
                TextField("Server URL", text: $settings.serverURL)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppSettings())
}
