import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section("General") {
                Toggle("Auto Unlock", isOn: .constant(true))
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
}
