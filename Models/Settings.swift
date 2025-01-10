//
//  Settings.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/9/25.
//

import SwiftData

@Model
class Settings {
    var theme: Theme
    var notificationsEnabled: Bool

    init(theme: Theme = Theme(), notificationsEnabled: Bool = true) {
        self.theme = theme
        self.notificationsEnabled = notificationsEnabled
    }
}
