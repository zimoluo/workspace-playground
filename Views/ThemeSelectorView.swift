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
            NewThemeCircle(selectedThemeId: $selectedThemeId)
                .onTapGesture {
                    withAnimation(.spring(duration: 0.15)) {
                        selectedThemeId = nil
                    }
                }

            Divider()
                .frame(width: 3, height: 44)
                .background(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 3))

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

            Divider()
                .frame(width: 3, height: 44)
                .background(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 3))

            HStack(spacing: 16) {
                if selectedThemeId != nil {
                    Button(action: {
                        deleteTheme(selectedThemeId)
                    }) {
                        Image(systemName: "trash")
                            .font(.system(size: 25, weight: .regular, design: .default))
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
                            .font(.system(size: 25, weight: .regular, design: .default))
                            .foregroundStyle(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 1))
                    }
                }

                Button(action: {
                    saveTheme(selectedThemeId)
                }) {
                    Image(systemName: "tray.and.arrow.down")
                        .font(.system(size: 25, weight: .regular, design: .default))
                        .foregroundStyle(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 1))
                }

                Button(action: {
                    showInfo = true
                }) {
                    Image(systemName: "info.square")
                        .font(.system(size: 25, weight: .regular, design: .default))
                        .foregroundStyle(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 1))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(themeColor(from: currentTheme, for: .secondary, in: colorScheme, level: 5))
        .cornerRadius(16)
        .shadow(color: currentTheme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
        .fullScreenCover(isPresented: $showInfo) {
            InfoFullScreenView(showInfo: $showInfo)
        }.presentationBackground(.clear)
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
            .fill(theme.thumbnail)
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

struct InfoFullScreenView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @Binding var showInfo: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring()) {
                        showInfo = false
                    }
                }

            VStack(spacing: 32) {
                Text("Using the Theme Maker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 150)
                    .padding(.top, 32)
                    .multilineTextAlignment(.center)
                    .themedForeground(using: theme, in: colorScheme)
                VStack(alignment: .leading, spacing: 36) {
                    HStack(spacing: 20) {
                        Image(systemName: "pencil.and.outline")
                            .font(.title)
                            .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 1))
                            .frame(width: 36, height: 36)
                        VStack(alignment: .leading) {
                            Text("Saving and Applying Themes")
                                .fontWeight(.semibold)
                                .font(.subheadline)
                                .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
                            Text("Save your custom theme with ease and reuse it anytime with just a tap.")
                                .font(.subheadline)
                                .opacity(0.7)
                                .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
                        }
                    }

                    HStack(spacing: 20) {
                        Image(systemName: "paintpalette.fill")
                            .font(.title)
                            .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 1))
                            .frame(width: 36, height: 36)
                        VStack(alignment: .leading) {
                            Text("Editing Accent Colors")
                                .fontWeight(.semibold)
                                .font(.subheadline)
                                .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
                            Text("Edit three accent colors with ease. WorkSpace adapts brightness and saturation to ensure your colors always look great!")
                                .font(.subheadline)
                                .opacity(0.7)
                                .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
                        }
                    }

                    HStack(spacing: 20) {
                        Image(systemName: "line.3.crossed.swirl.circle.fill")
                            .font(.title)
                            .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 1))
                            .frame(width: 36, height: 36)
                        VStack(alignment: .leading) {
                            Text("Playing with Gradient")
                                .fontWeight(.semibold)
                                .font(.subheadline)
                                .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
                            Text("Create stunning backgrounds with linear, radial, conic, or mesh gradients. WorkSpace’s playground simplifies the process, and its smart color algorithm guarantees gorgeous results.")
                                .font(.subheadline)
                                .opacity(0.7)
                                .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
                        }
                    }
                }.padding(.horizontal, 128)
                Spacer()
                Button(action: { withAnimation(.spring()) {
                    showInfo = false
                }}) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(themeColor(from: theme, in: colorScheme, level: 1))
                            .frame(height: 56)

                        Text("Got it!")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .themedForeground(using: theme, in: colorScheme, level: 5)
                    }
                    .shadow(color: theme.primary.toShadow(), radius: 12, y: 8)
                }
                .padding(.horizontal, 144)
                .padding(.bottom, 32)
            }
            .frame(maxWidth: 600, maxHeight: 800)
            .background(LinearGradient(colors: [themeColor(from: theme, for: .primary, in: colorScheme, level: 4), themeColor(from: theme, for: .primary, in: colorScheme, level: 5)], startPoint: .top, endPoint: .bottom))
            .cornerRadius(16)
            .shadow(color: theme.primary.toShadow(), radius: 16, y: 8)
            .padding(40)
        }
        .transition(.opacity)
    }
}
