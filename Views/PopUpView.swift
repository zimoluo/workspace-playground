import SwiftUI

struct PopUpView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var popUp: PopUp

    var body: some View {
        ZStack {
            if popUp.type != .empty {
                Color.black
                    .opacity(colorScheme == .light ? 0.25 : 0.75)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.spring(duration: 0.1), value: popUp.type)

                contentView()
                    .ignoresSafeArea()
                    .transition(
                        AnyTransition.asymmetric(
                            insertion: .opacity.combined(with: .offset(y: 70)),
                            removal: .opacity.combined(with: .offset(y: -40))
                        )
                    )
                    .animation(.spring(duration: 0.2), value: popUp.type)
            }
        }
        .animation(.spring(duration: 0.2), value: popUp.type)
    }

    @ViewBuilder
    private func contentView() -> some View {
        switch popUp.type {
        case .empty:
            EmptyView()
        case .themeMakerGuide:
            VStack(spacing: 30) {
                Text("Exploring the Theme Maker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 150)
                    .padding(.top, 44)
                    .multilineTextAlignment(.center)
                    .themedForeground(using: theme, in: colorScheme)
                VStack(alignment: .leading, spacing: 36) {
                    HStack(spacing: 16) {
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

                    HStack(spacing: 16) {
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

                    HStack(spacing: 16) {
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
                }
                .padding(.horizontal, 140)

                Spacer()

                Button(action: { withAnimation(.spring()) {
                    popUp.type = .empty
                }}) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(themeColor(from: theme, in: colorScheme, level: 1))
                            .frame(height: 50)

                        Text("Got it!")
                            .fontWeight(.semibold)
                            .themedForeground(using: theme, in: colorScheme, level: 5)
                    }
                    .shadow(color: theme.primary.toShadow(), radius: 12, y: 8)
                }
                .padding(.horizontal, 132)
                .padding(.bottom, 56)
            }
            .frame(maxWidth: 618, maxHeight: 800)
            .background(LinearGradient(colors: [themeColor(from: theme, for: .primary, in: colorScheme, level: 4), themeColor(from: theme, for: .primary, in: colorScheme, level: 5)], startPoint: .top, endPoint: .bottom))
            .cornerRadius(16)
            .shadow(color: theme.primary.toShadow(), radius: 16, y: 8)
            .padding(48)
        }
    }
}
