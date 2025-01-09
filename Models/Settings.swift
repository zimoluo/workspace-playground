//
//  Settings.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import Foundation
import SwiftData

@Model
class Settings: ObservableObject {
    var theme: Theme
    var additionalSettings: [String: AnyCodable]

    init(theme: Theme, additionalSettings: [String: AnyCodable] = [:]) {
        self.theme = theme
        self.additionalSettings = additionalSettings
    }

    func updateSettings(key: String, value: AnyCodable) {
        additionalSettings[key] = value
    }
}
