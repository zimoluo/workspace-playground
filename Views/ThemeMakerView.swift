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
            theme.mainGradient.toGradient(in: colorScheme).ignoresSafeArea()
            ScrollView {
                VStack(spacing: 32) {
                    VStack(spacing: 8) {
                        HStack {
                            Text("Interface")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 6)
                                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
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
                                Button(action: {
                                    let primaryColor = RGBAColor.randomBright()
                                    theme.primary = primaryColor
                                    theme.secondary = primaryColor.secondaryColor()
                                    theme.tertiary = primaryColor.tertiaryColor()
                                }) {
                                    Image(systemName: "wand.and.sparkles")
                                        .font(.title)
                                        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
                                }
                                Button(action: {
                                    theme.primary = RGBAColor.randomBright()
                                    theme.secondary = RGBAColor.randomBright()
                                    theme.tertiary = RGBAColor.randomBright()
                                }) {
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
                        HStack {
                            Text("Background")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 6)
                                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                            Spacer()
                        }
                        HStack(spacing: 12) {
                            GradientTypeSelectorView()
                                .frame(height: 400)
                                .frame(maxWidth: 80.88)

                            VStack(spacing: 12) {
                                GradientStopEditorView()
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 12)
                                    .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                                    .cornerRadius(16)
                                    .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                                HStack(spacing: 12) {
                                    ConnectPointsPanel()
                                        .padding(24)
                                        .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                                        .cornerRadius(16)
                                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                                        .contentShape(RoundedRectangle(cornerRadius: 16))
                                    ZStack {
                                        theme.mainGradient.toGradient(in: colorScheme)

                                        Rectangle()
                                            .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                                            .mask(
                                                LinearGradient(
                                                    gradient: Gradient(stops: [
                                                        .init(color: .black, location: 0), // Fully visible
                                                        .init(color: .clear, location: 0.15),
                                                        .init(color: .clear, location: 0.85),
                                                        .init(color: .black, location: 1)
                                                    ]),
                                                    startPoint: .leading,
                                                    endPoint: .trailing
                                                )
                                            )

                                        Rectangle()
                                            .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                                            .mask(
                                                LinearGradient(
                                                    gradient: Gradient(stops: [
                                                        .init(color: .black, location: 0),
                                                        .init(color: .clear, location: 0.15),
                                                        .init(color: .clear, location: 0.85),
                                                        .init(color: .black, location: 1)
                                                    ]),
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )

                                        Rectangle()
                                            .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                                            .mask(
                                                EllipticalGradient(
                                                    gradient: Gradient(stops: [
                                                        .init(color: .clear, location: 0),
                                                        .init(color: .clear, location: 0.5),
                                                        .init(color: .black, location: 0.65)
                                                    ]),
                                                    center: .center, startRadiusFraction: 0, endRadiusFraction: 1.08
                                                )
                                            )
                                    }
                                    .cornerRadius(16)
                                    .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                                    .frame(maxWidth: 240, maxHeight: .infinity)
                                }.frame(maxHeight: .infinity)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 4))
                        .cornerRadius(16).shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)
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
