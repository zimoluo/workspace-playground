//
//  ThemeManager.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import Foundation
import SwiftData

class ThemeManager: ObservableObject {
    @Published var theme: Theme

    init(theme: Theme) {
        self.theme = theme
    }
}
