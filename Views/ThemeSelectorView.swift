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
        HStack(spacing: 20) {
            // Dashed Circle for creating a new theme
            NewThemeCircle(selectedThemeId: $selectedThemeId)
                .onTapGesture {
                    withAnimation(.spring(duration: 0.15)) {
                        selectedThemeId = nil
                    }
                }

            // Vertical Separator
            Divider()
                .frame(width: 3, height: 44)
                .background(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 3))

            // Horizontal ScrollView of existing themes
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(themes.filter { $0.id != currentTheme.id }) { theme in
                        ThemeCircle(theme: theme, isSelected: theme.id == selectedThemeId)
                            .onTapGesture {
                                withAnimation(.spring(duration: 0.15)) {
                                    selectedThemeId = theme.id
                                }
                            }
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.6)
                                    .blur(radius: phase.isIdentity ? 0 : 10)
                            }
                    }
                }
            }
            .frame(height: 44)

            // Another Vertical Separator
            Divider()
                .frame(width: 3, height: 44)
                .background(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 3))

            // Info, Load, and Save Buttons
            HStack(spacing: 8) {
                if selectedThemeId != nil {
                    Button(action: {
                        deleteTheme(selectedThemeId)
                    }) {
                        Image(systemName: "trash")
                            .font(.title)
                            .foregroundStyle(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 1))
                    }
                }

                if selectedThemeId != nil {
                    Button(action: {
                        if let selected = selectedThemeId {
                            applyTheme(selected)
                        }
                    }) {
                        Image(systemName: "pencil.and.outline")
                            .font(.title)
                            .foregroundStyle(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 1))
                    }
                }

                // Save Button
                Button(action: {
                    saveTheme(selectedThemeId)
                }) {
                    Image(systemName: "tray.and.arrow.down")
                        .font(.title)
                        .foregroundStyle(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 1))
                }

                Button(action: {
                    showInfo.toggle()
                }) {
                    Image(systemName: "info.square")
                        .font(.title)
                        .foregroundStyle(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 1))
                }
                .popover(isPresented: $showInfo) {
                    InfoPopoverView()
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
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
        matchingTheme.mainGradient = copiedTheme.mainGradient
    }

    private func createNewTheme() {
        let newTheme = currentTheme.deepCopy()

        withAnimation(.spring(duration: 0.15)) {
            modelContext.insert(newTheme)
            selectedThemeId = newTheme.id
        }
    }

    private func deleteTheme(_ id: UUID?) {
        guard let id = id, let themeToDelete = themes.first(where: { $0.id == id }) else {
            return
        }

        withAnimation(.spring(duration: 0.15)) {
            modelContext.delete(themeToDelete)
            selectedThemeId = nil
        }
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

    @Binding var selectedThemeId: UUID?

    var body: some View {
        Circle()
            .fill(selectedThemeId == nil ? themeColor(from: theme, for: .secondary, in: colorScheme, level: 2).opacity(0.33) : .clear)
            .stroke(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [4, 10]))
            .frame(width: 38, height: 38)
            .contentShape(Circle())
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
                isSelected ?
                    Circle()
                    .stroke(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5), lineWidth: 3.5)
                    .frame(width: 35, height: 35) : nil
            )
            .frame(width: 44, height: 44)
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
