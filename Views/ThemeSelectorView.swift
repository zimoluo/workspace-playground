//
//  ThemeSelectorView.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/16/25.
//

import SwiftData
import SwiftUI

struct ThemeSelectorView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Theme.dateCreated, order: .reverse) var themes: [Theme]
    @State var selectedThemeId: UUID? = nil
    @Environment(\.theme) private var currentTheme
    @Environment(\.colorScheme) private var colorScheme
    @State private var showInfo = false

    var body: some View {
        HStack(spacing: 16) {
            // Dashed Circle for creating a new theme
            NewThemeCircle()
                .frame(width: 48, height: 48)
                .onTapGesture {
                    selectedThemeId = nil // Indicates creation of a new theme
                }

            // Vertical Separator
            Divider()
                .frame(height: 48)
                .background(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 3))

            // Horizontal ScrollView of existing themes
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(themes.filter { $0.id != currentTheme.id }) { theme in
                        ThemeCircle(theme: theme, isSelected: theme.id == selectedThemeId)
                            .onTapGesture {
                                selectedThemeId = theme.id
                            }
                    }
                }
                .padding(.horizontal, 8)
            }
            .frame(height: 48)

            // Another Vertical Separator
            Divider()
                .frame(height: 48)
                .background(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 3))

            // Info, Load, and Save Buttons
            HStack(spacing: 8) {
                // Info Button
                Button(action: {
                    showInfo.toggle()
                }) {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .foregroundStyle(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 1))
                }
                .popover(isPresented: $showInfo) {
                    InfoPopoverView()
                }

                // Load Button
                Button(action: {
                    if let selected = selectedThemeId {
                        applyTheme(selected)
                    }
                }) {
                    Image(systemName: "arrow.down.circle")
                        .font(.title2)
                        .foregroundStyle(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 1))
                }

                // Save Button
                Button(action: {
                    saveTheme(selectedThemeId)
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title2)
                        .foregroundStyle(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 1))
                }
            }
        }
        .padding(8)
        .background(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 5))
        .cornerRadius(16)
        .shadow(color: currentTheme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
    }

    private func applyTheme(_ id: UUID?) {
        guard let matchingTheme = themes.first(where: { $0.id == id }) else {
            return
        }

        if !themes.contains(where: { $0.id != currentTheme.id && $0 == currentTheme }) {
            createNewTheme()
            selectedThemeId = matchingTheme.id
        }

        let copiedTheme = matchingTheme.deepCopy()

        currentTheme.primary = copiedTheme.primary
        currentTheme.secondary = copiedTheme.secondary
        currentTheme.tertiary = copiedTheme.tertiary
        currentTheme.mainGradient = copiedTheme.mainGradient
    }

    private func saveTheme(_ id: UUID?) {
        guard let matchingTheme = themes.first(where: { $0.id == id }) else {
            createNewTheme()
            return
        }

        let copiedTheme = currentTheme.deepCopy()

        matchingTheme.primary = copiedTheme.primary
        matchingTheme.secondary = copiedTheme.secondary
        matchingTheme.tertiary = copiedTheme.tertiary
    }

    private func createNewTheme() {
        let newTheme = currentTheme.deepCopy()
        modelContext.insert(newTheme)
        selectedThemeId = newTheme.id
    }
}

struct ThemeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSelectorView()
            .environment(\.theme, Theme( /* Initialize with sample data */ ))
    }
}

struct NewThemeCircle: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.theme) private var theme

    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
            .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 3))
            .overlay(
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
            )
    }
}

struct ThemeCircle: View {
    var theme: Theme
    var isSelected: Bool
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Circle()
            .fill(
                theme.thumbnail
            )
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 3)
                    .shadow(color: Color.black.opacity(isSelected ? 0.2 : 0), radius: 4, y: 2)
            )
            .frame(width: 48, height: 48)
            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 4, y: 2)
    }
}

struct InfoPopoverView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Theme Maker")
                .font(.headline)
            Text("Create, save, and apply custom themes to personalize your workspace. Tap on a theme to select it, use the buttons to load or save themes, and tap the plus circle to create a new theme.")
                .font(.subheadline)
            Button("Got it!") {
                // Dismiss logic if needed
            }
            .padding(.top, 8)
        }
        .padding()
        .frame(width: 300)
    }
}
