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
            PopUpContent(
                title: "Exploring the Theme Maker",
                items: [
                    PopUpItem(
                        icon: "pencil.and.outline",
                        title: "Saving and Applying Themes",
                        description: "Save your custom theme and reuse it anytime with just a tap."
                    ),
                    PopUpItem(
                        icon: "paintpalette.fill",
                        title: "Editing Accent Colors",
                        description: "Edit three accent colors with ease. WorkSpace adapts brightness and saturation to ensure your colors always look great!"
                    ),
                    PopUpItem(
                        icon: "line.3.crossed.swirl.circle.fill",
                        title: "Playing with Gradient",
                        description: "Create stunning backgrounds with linear, radial, conic, or mesh gradients. WorkSpace’s toolset simplifies the process, and its smart color algorithm guarantees gorgeous results."
                    )
                ],
                buttonText: "Got it!",
                buttonAction: {
                    withAnimation(.spring()) {
                        popUp.type = .empty
                    }
                }
            )
        }
    }
}

struct PopUpContent: View {
    let title: String
    let items: [PopUpItem]
    let buttonText: String
    let buttonAction: () -> Void

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 30) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal, 150)
                .padding(.top, 44)
                .multilineTextAlignment(.center)
                .themedForeground(using: theme, in: colorScheme)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 36) {
                    ForEach(items, id: \.id) { item in
                        HStack(spacing: 16) {
                            Image(systemName: item.icon)
                                .font(.title)
                                .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 1))
                                .frame(width: 36, height: 36)
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .fontWeight(.semibold)
                                    .font(.subheadline)
                                    .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
                                Text(item.description)
                                    .font(.subheadline)
                                    .opacity(0.7)
                                    .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
                            }
                        }
                    }
                }
                .padding(.horizontal, 140)
            }

            Spacer()

            Button(action: buttonAction) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(themeColor(from: theme, in: colorScheme, level: 1))
                        .frame(height: 50)

                    Text(buttonText)
                        .fontWeight(.semibold)
                        .themedForeground(using: theme, in: colorScheme, level: 5)
                }
                .shadow(color: theme.primary.toShadow(), radius: 12, y: 8)
            }
            .padding(.horizontal, 132)
            .padding(.bottom, 56)
        }
        .frame(maxWidth: 618, maxHeight: 800)
        .background(
            LinearGradient(
                colors: [
                    themeColor(from: theme, for: .primary, in: colorScheme, level: 4),
                    themeColor(from: theme, for: .primary, in: colorScheme, level: 5)
                ],
                startPoint: .top, endPoint: .bottom
            )
        )
        .cornerRadius(16)
        .shadow(color: theme.primary.toShadow(), radius: 16, y: 8)
        .padding(48)
    }
}

struct PopUpItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
}
