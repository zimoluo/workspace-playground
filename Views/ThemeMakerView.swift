import SwiftData
import SwiftUI

struct ThemeMakerView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var popUp: PopUp

    var body: some View {
        VStack {
            ThemeMaker()
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 4))
                .cornerRadius(16)
                .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 32)
        .padding(.vertical, 0)
        .ignoresSafeArea()
        .task {
            showGuideFirstTime()
        }
    }

    private func showGuideFirstTime() {
        let hasSeenThemeMakerGuide = UserDefaults.standard.bool(forKey: "HasSeenThemeMakerGuide")

        guard !hasSeenThemeMakerGuide else {
            return
        }

        popUp.type = .themeMakerGuide

        UserDefaults.standard.set(true, forKey: "HasSeenThemeMakerGuide")
    }
}

struct ThemeMaker: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var popUp: PopUp

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                    .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)
                    .frame(height: 64)

                ThemeSelectorView()
            }
            .frame(height: 64)

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
                .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)

                Grid(horizontalSpacing: 10, verticalSpacing: 16) {
                    GridRow {
                        ForEach((0...5).reversed(), id: \.self) { level in
                            Rectangle()
                                .fill(themeColor(from: theme, for: .primary, in: colorScheme, level: level))
                                .cornerRadius(8)
                                .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                        }
                    }
                    GridRow {
                        ForEach((0...5).reversed(), id: \.self) { level in
                            Rectangle()
                                .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: level))
                                .cornerRadius(8)
                                .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                        }
                    }
                    GridRow {
                        ForEach((0...5).reversed(), id: \.self) { level in
                            Rectangle()
                                .fill(themeColor(from: theme, for: .tertiary, in: colorScheme, level: level))
                                .cornerRadius(8)
                                .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .cornerRadius(16)
                .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)

                VStack(spacing: 12) {
                    Button(action: {
                        let primaryColor = RGBAColor.randomBright()
                        theme.primary = primaryColor
                        theme.secondary = primaryColor.secondaryColor()
                        theme.tertiary = primaryColor.tertiaryColor()
                    }) {
                        Image(systemName: "wand.and.sparkles")
                            .font(.system(size: 28))
                            .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                    }
                    Button(action: {
                        theme.primary = RGBAColor.randomBright()
                        theme.secondary = RGBAColor.randomBright()
                        theme.tertiary = RGBAColor.randomBright()
                    }) {
                        Image(systemName: "dice")
                            .font(.system(size: 28))
                            .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                    }
                    Spacer()
                }
                .padding(8)
                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .cornerRadius(16)
                .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)
            }
            .frame(height: 164)

            HStack(spacing: 12) {
                GradientTypeSelectorView()
                    .frame(height: 400)
                    .frame(maxWidth: 80.88)

                if theme.mainGradient.type == .mesh {
                    MeshGradientEditorView()
                } else { VStack(spacing: 12) {
                    GradientStopEditorView()
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                        .cornerRadius(16)
                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                    HStack(spacing: 12) {
                        ConnectPointsPanel()
                            .padding(32)
                            .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                            .cornerRadius(16)
                            .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)
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
                        .shadow(color: theme.secondary.toShadow(), radius: 12, y: 8)
                        .frame(maxWidth: 240, maxHeight: .infinity)
                    }.frame(maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(height: 400)
        }
    }
}
