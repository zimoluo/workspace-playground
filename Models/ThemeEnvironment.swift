//
//  ThemeKey.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/11/25.
//

import SwiftUI

struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .init() // Provide a default theme
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
