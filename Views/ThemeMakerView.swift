//
//  File.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/12/25.
//

import Foundation
import SwiftUI

struct ThemeMakerView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            theme.mainGradient.toGradient().ignoresSafeArea()
            ScrollView {
                VStack(spacing: 32) {
                    VStack(spacing: 8) {
                        HStack {
                            Text("Interface")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .opacity(0.8)
                                .padding(.horizontal, 6)
                                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
                            Spacer()
                        }

                        HStack(spacing: 12) {
                            VStack(spacing: 4) {
                                ColorPicker("",
                                            selection: Binding(
                                                get: { theme.primary.color },
                                                set: { theme.primary = RGBAColor($0) }
                                            ),
                                            supportsOpacity: false)
                                    .labelsHidden()
                                    .padding(12)

                                ColorPicker("",
                                            selection: Binding(
                                                get: { theme.secondary.color },
                                                set: { theme.secondary = RGBAColor($0) }
                                            ),
                                            supportsOpacity: false)
                                    .labelsHidden()

                                ColorPicker("",
                                            selection: Binding(
                                                get: { theme.tertiary.color },
                                                set: { theme.tertiary = RGBAColor($0) }
                                            ),
                                            supportsOpacity: false)
                                    .labelsHidden()
                                    .padding(12)
                            }
                            .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                            .cornerRadius(16)
                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)

                            Grid(horizontalSpacing: 10, verticalSpacing: 16) {
                                GridRow {
                                    ForEach((0...5).reversed(), id: \.self) { level in
                                        Rectangle()
                                            .fill(themeColor(from: theme, for: .primary, in: colorScheme, level: level))
                                            .cornerRadius(8)
                                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    }
                                }
                                GridRow {
                                    ForEach((0...5).reversed(), id: \.self) { level in
                                        Rectangle()
                                            .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: level))
                                            .cornerRadius(8)
                                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    }
                                }
                                GridRow {
                                    ForEach((0...5).reversed(), id: \.self) { level in
                                        Rectangle()
                                            .fill(themeColor(from: theme, for: .tertiary, in: colorScheme, level: level))
                                            .cornerRadius(8)
                                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                            .cornerRadius(16)
                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)

                            VStack(spacing: 8) {
                                Button(action: {}) {
                                    Image(systemName: "wand.and.sparkles")
                                        .font(.title)
                                        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
                                }
                                Button(action: {}) {
                                    Image(systemName: "bubbles.and.sparkles")
                                        .font(.title)
                                        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
                                }
                                Spacer()
                            }
                            .padding(8)
                            .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                            .cornerRadius(16)
                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                        }.padding(12)
                            .frame(maxWidth: .infinity)
                            .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 4))
                            .cornerRadius(16).shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)
                    }

                    VStack(spacing: 8) {
                        // Title
                        HStack {
                            Text("Background")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .opacity(0.75)
                                .padding(.horizontal, 8)
                                .themedForeground(using: theme, in: colorScheme)
                            Spacer()
                        }
                        // Content
                        HStack(spacing: 12) {
                            // Two big rectangles
                            Rectangle()
                                .fill(Color.green) // Color placeholder for the rectangles
                                .frame(maxWidth: .infinity, minHeight: 180).cornerRadius(12)
                            Rectangle()
                                .fill(Color.yellow) // Color placeholder for the rectangles
                                .frame(maxWidth: .infinity, minHeight: 180).cornerRadius(12)

                            // Small strip rectangle with buttons
                            VStack(spacing: 8) {
                                Button(action: {
                                    theme.tertiary = RGBAColor.randomBright()
                                }) {
                                    Image(systemName: "wand.and.sparkles")
                                        .font(.title)
                                }
                                Button(action: {
                                    theme.primary = RGBAColor.randomBright()
                                    theme.secondary = RGBAColor.randomBright()
                                    theme.tertiary = RGBAColor.randomBright()
                                }) {
                                    Image(systemName: "bubbles.and.sparkles")
                                        .font(.title)
                                }
                                Spacer()
                            }
                            .padding(8)
                            .background(Color.gray)
                            .cornerRadius(12)
                        }.padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(16)
                    }
                }
                .padding(32)
            }
        }.toolbar {
            ToolbarItem(placement: .navigation) {
                Text("Theme Maker")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
                    .frame(alignment: .leading)
                    .padding(.horizontal, 4)
            }
        }
    }
}
