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
                                .opacity(0.75)
                                .padding(.horizontal, 6)
                                .themed(using: theme, in: colorScheme)
                            Spacer()
                        }

                        HStack(spacing: 16) {
                            VStack(spacing: 4) {
                                ColorPicker("Primary color", selection: Binding(
                                    get: { theme.primary.color },
                                    set: { newColor in
                                        theme.primary = RGBAColor(newColor)
                                    }
                                ), supportsOpacity: false).labelsHidden().padding(12)
                                ColorPicker("Secondary color", selection: Binding(
                                    get: { theme.secondary.color },
                                    set: { newColor in
                                        theme.secondary = RGBAColor(newColor)
                                    }
                                ), supportsOpacity: false).labelsHidden()
                                ColorPicker("Tertiary color", selection: Binding(
                                    get: { theme.tertiary.color },
                                    set: { newColor in
                                        theme.tertiary = RGBAColor(newColor)
                                    }
                                ), supportsOpacity: false).labelsHidden().padding(12)
                            }
                            .background(themeColor(from: theme, for: "secondary", in: colorScheme, level: 5)).cornerRadius(16)
                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)

                            Grid(horizontalSpacing: 10, verticalSpacing: 16) {
                                GridRow {
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "primary", in: colorScheme, level: 5)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "primary", in: colorScheme, level: 4)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "primary", in: colorScheme, level: 3)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "primary", in: colorScheme, level: 2)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "primary", in: colorScheme, level: 1)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "primary", in: colorScheme, level: 0)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                }
                                GridRow {
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "secondary", in: colorScheme, level: 5)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "secondary", in: colorScheme, level: 4)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "secondary", in: colorScheme, level: 3)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "secondary", in: colorScheme, level: 2)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "secondary", in: colorScheme, level: 1)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "secondary", in: colorScheme, level: 0)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                }
                                GridRow {
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "tertiary", in: colorScheme, level: 5)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "tertiary", in: colorScheme, level: 4)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "tertiary", in: colorScheme, level: 3)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "tertiary", in: colorScheme, level: 2)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "tertiary", in: colorScheme, level: 1)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                    Rectangle()
                                        .fill(themeColor(from: theme, for: "tertiary", in: colorScheme, level: 0)).cornerRadius(8).shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 12, y: 8)
                                }
                            }.frame(maxWidth: .infinity)
                                .padding(12)
                                .background(themeColor(from: theme, for: "secondary", in: colorScheme, level: 5))
                                .cornerRadius(16)
                                .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)

                            // Small strip rectangle with buttons
                            VStack(spacing: 8) {
                                Button(action: {
                                    // Magic star button action
                                }) {
                                    Image(systemName: "wand.and.sparkles")
                                        .font(.title).foregroundStyle(themeColor(from: theme, for: "secondary", in: colorScheme, level: 0))
                                }
                                Button(action: {
                                    // Die button action
                                }) {
                                    Image(systemName: "bubbles.and.sparkles")
                                        .font(.title)
                                        .foregroundStyle(themeColor(from: theme, for: "secondary", in: colorScheme, level: 0))
                                }
                                Spacer()
                            }
                            .padding(8)
                            .background(themeColor(from: theme, for: "secondary", in: colorScheme, level: 5)).cornerRadius(16)
                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                        }.padding(16)
                            .frame(maxWidth: .infinity)
                            .background(themeColor(from: theme, for: "secondary", in: colorScheme, level: 4))
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
                                .themed(using: theme, in: colorScheme)
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
                                    // Magic star button action
                                }) {
                                    Image(systemName: "wand.and.sparkles")
                                        .font(.title)
                                }
                                Button(action: {
                                    // Die button action
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
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Theme Maker")
                    .font(.title)
                    .fontWeight(.bold)
                    .themed(using: theme, in: colorScheme)
                    .frame(maxWidth: .infinity, alignment: .leading) // Ensures it aligns left
            }
        }
    }
}
