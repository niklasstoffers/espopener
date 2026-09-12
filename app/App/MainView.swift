import SwiftUI

struct MainView: View {
    @EnvironmentObject private var settings: AppSettings

    var body: some View {
        if settings.initialSetupComplete {
            NavigationStack() {
                HomeView()
            }
        } else {
            SetupView()
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AppSettings())
}
