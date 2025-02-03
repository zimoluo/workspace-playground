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

                contentView()
                    .ignoresSafeArea()
                    .transition(
                        .opacity.combined(
                            with: .offset(y: UIScreen.main.bounds.height)
                        )
                    )
            }
        }
        .animation(.smooth(duration: 0.5), value: popUp.type)
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
                        title: "Playing with Gradients",
                        description: "Create stunning backgrounds with linear, radial, conic, or mesh gradients. WorkSpace’s toolset makes it easy to create stunning gradients. Its smart color algorithm ensures beautiful results."
                    )
                ],
                buttonText: "Got it!",
                buttonAction: {
                    popUp.type = .empty
                }
            )
        case .tips_menu:
            PopUpContent(
                title: "Well of Wisdom:\nKnowing the Tools",
                items: [
                    PopUpItem(
                        icon: "rectangle.3.group.fill",
                        title: "Organizing Windows",
                        description: "Lost in the vast Space? Reclaim windows with a tap. WorkSpace’s smart algorithm knows window sizes and positions them perfectly."
                    ),
                    PopUpItem(
                        icon: "mappin.circle.fill",
                        title: "Placing Markers",
                        description: "Sometimes a Space can have different zones. Place a Marker to quickly travel between and preview different areas."
                    ),
                    PopUpItem(
                        icon: "lock.fill",
                        title: "Locking the Frame",
                        description: "Maximize your screen’s real estate. Lock the frame to keep your windows exactly where you want them."
                    )
                ],
                buttonText: "Good to know!",
                buttonAction: {
                    popUp.type = .empty
                }
            )
        case .tips_theme:
            PopUpContent(
                title: "Well of Wisdom:\nMaking Themes",
                items: [
                    PopUpItem(
                        icon: "paintpalette.fill",
                        title: "Changing Themes",
                        description: "Try out different themes! WorkSpace offers four gorgeous themes to choose from. Each is great yet distinct."
                    ),
                    PopUpItem(
                        icon: "book.fill",
                        title: "Learning the Basics",
                        description: "A theme features three accent colors and a fully customizable backdrop gradient. They apply to every aspect of WorkSpace, from the color of windows to the appearance of menu."
                    ),
                    PopUpItem(
                        icon: "command",
                        title: "Trying out the Theme Maker",
                        description: "The Theme Maker is where you can fully express yourself by creating your own theme. It's intuitive, intelligent, and rewarding. Try it out!"
                    )
                ],
                buttonText: "Good to know!",
                buttonAction: {
                    popUp.type = .empty
                }
            )
        case .tips_technical:
            PopUpContent(
                title: "Well of Wisdom:\nDid you know?",
                items: [
                    PopUpItem(
                        icon: "square.grid.3x3.square",
                        title: "Dot Grid",
                        description: "Did you know that the dot grid is rendered using Metal? It provides a great navigation experience while keeping the app running buttery smooth."
                    ),
                    PopUpItem(
                        icon: "line.3.crossed.swirl.circle.fill",
                        title: "Mesh Gradient",
                        description: "Did you know that the default theme uses a mesh gradient background? Try the mesh gradient in the Theme Maker! You can customize vertices, colors, and so much more. It's the best way to express your understanding of colors."
                    ),
                    PopUpItem(
                        icon: "infinity",
                        title: "Edge of the Space",
                        description: "Did you know that the boundary of the Space is one billion units away from the start? It takes half a year to scroll there without stopping, so don't try to reach it!"
                    )
                ],
                buttonText: "Good to know!",
                buttonAction: {
                    popUp.type = .empty
                }
            )
        case .tips_window:
            PopUpContent(
                title: "Well of Wisdom:\nWindows Facts",
                items: [
                    PopUpItem(
                        icon: "deskclock.fill",
                        title: "The First Window",
                        description: "The analog clock is the first window ever created in WorkSpace! It has a clean yet elegant design, and it looks even better in oval shapes!"
                    ),
                    PopUpItem(
                        icon: "note.text",
                        title: "Not Just Notes",
                        description: "Notes is not just a text editor. You can change the text's color, size, and style, and even insert your favorite Stickers and Genmojis!"
                    ),
                    PopUpItem(
                        icon: "stopwatch.fill",
                        title: "Stopwatch Doesn't Stop",
                        description: "If you leave a stopwatch running, it will continue even when you exit the Space or the entire app! It's always a big surprise to see the stopwatch running for days on end."
                    )
                ],
                buttonText: "Good to know!",
                buttonAction: {
                    popUp.type = .empty
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
