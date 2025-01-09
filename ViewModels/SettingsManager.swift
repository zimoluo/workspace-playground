//
//  SettingsManager.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import Foundation

class SettingsManager: ObservableObject {
    @Published var settings: Settings

    init(settings: Settings) {
        self.settings = settings
    }
}
