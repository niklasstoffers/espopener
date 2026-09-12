import Foundation
import Combine

private let defaultServerURL = "https://espopener.local"

private enum SettingsKey {
    static let initialSetupComplete = "initialSetupComplete"
    static let autoUnlock = "autoUnlock"
    static let serverURL = "serverURL"
}

@MainActor
final class AppSettings: ObservableObject {
    private let defaults: UserDefaults

    @Published var initialSetupComplete: Bool {
        didSet { defaults.set(initialSetupComplete, forKey: SettingsKey.initialSetupComplete) }
    }

    @Published var autoUnlock: Bool {
        didSet { defaults.set(autoUnlock, forKey: SettingsKey.autoUnlock) }
    }

    @Published var serverURL: String {
        didSet { defaults.set(serverURL, forKey: SettingsKey.serverURL) }
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.initialSetupComplete = defaults.bool(forKey: SettingsKey.initialSetupComplete)
        self.autoUnlock = defaults.object(forKey: SettingsKey.autoUnlock) as? Bool ?? true
        self.serverURL = defaults.string(forKey: SettingsKey.serverURL) ?? defaultServerURL
    }
}
