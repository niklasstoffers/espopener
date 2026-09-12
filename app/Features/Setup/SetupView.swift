import SwiftUI

private enum SetupStep: Int, CaseIterable {
    case welcome
    case serverSetup
    case finish
}

struct SetupView: View {
    @State private var step: SetupStep = .welcome
    @EnvironmentObject private var settings: AppSettings
    
    var body: some View {
        VStack {
            TabView(selection: $step) {
                SetupStepWelcomeView()
                    .tag(SetupStep.welcome)
                
                SetupStepServerSetupView()
                    .tag(SetupStep.serverSetup)

                SetupStepFinishView()
                    .tag(SetupStep.finish)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))

            Button(step == .finish ? "Complete" : "Continue") {
                if step == .finish {
                    settings.initialSetupComplete = true
                } else {
                    goForward()
                }
            }
            
            if step != .welcome {
                Button("Back") {
                    goBack()
                }
            }
        }
    }

    private func goBack() {
        guard let previous = SetupStep(rawValue: step.rawValue - 1) else {
            return
        }

        step = previous
    }

    private func goForward() {
        guard let next = SetupStep(rawValue: step.rawValue + 1) else {
            return
        }

        step = next
    }
}

#Preview {
    SetupView()
        .environmentObject(AppSettings())
}
