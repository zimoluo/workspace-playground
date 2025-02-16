import SwiftUI

struct SettingsKey: EnvironmentKey {
    static let defaultValue: Settings = .init()
}

extension EnvironmentValues {
    var settings: Settings {
        get { self[SettingsKey.self] }
        set { self[SettingsKey.self] = newValue }
    }
}
