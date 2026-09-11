import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home")
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gearshape")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
