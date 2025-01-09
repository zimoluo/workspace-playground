//
//  GradientUtils.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftUI

enum GradientUtils {
    static func gradientFromModel(_ gradient: ColorGradient) -> Gradient {
        Gradient(colors: gradient.colors.map { ColorUtils.colorFromRGB($0) })
    }
}
