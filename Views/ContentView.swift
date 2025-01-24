import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Theme.dateCreated, order: .reverse) var themes: [Theme]
    @Query(sort: \Space.dateModified, order: .reverse) var spaces: [Space]
    @Environment(\.theme) private var theme
    @Environment(\.settings) private var settings
    @Environment(\.colorScheme) private var colorScheme

    @State private var selectedScreen: Screen = .init(type: .space)

    @State private var columnVisibility: NavigationSplitViewVisibility = .automatic

    private let columns: [GridItem] = Array(repeating: .init(.fixed(36), spacing: 16), count: 5)
    private let maxThemesGridHeight: CGFloat = 120

    var body: some View {
        ZStack {
            NavigationSplitView(columnVisibility: $columnVisibility) {
                VStack(spacing: 0) {
                    HStack {
                        Text("WorkSpace")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .themedForeground(using: theme, in: colorScheme)
                        Spacer()
                    }
                    .padding(20)
                    .padding(.top, 32)

                    VStack(spacing: 8) {
                        SectionView(header: "Spaces", trailing: {
                            HStack(spacing: 8) {
                                if !spaces.isEmpty {
                                    Button(action: {
                                        deleteSpace(settings.selectedSpaceId)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(
                                                themeColor(from: theme, for: .primary, in: colorScheme, level: 0)
                                            )
                                    }
                                }

                                Button(action: {
                                    addSpace()
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundColor(
                                            themeColor(from: theme, for: .primary, in: colorScheme, level: 0)
                                        )
                                }
                            }
                        }) {
                            ScrollView {
                                LazyVStack(alignment: .leading, spacing: 20) {
                                    ForEach(spaces) { space in
                                        Button(action: {
                                            withAnimation(.spring(duration: 0.2)) {
                                                selectedScreen.type = .space
                                                settings.selectedSpaceId = space.id
                                            }
                                        }) {
                                            HStack {
                                                Text("New Space")
                                                    .foregroundColor(
                                                        selectedScreen.type == .space && settings.selectedSpaceId == space.id ?
                                                            themeColor(from: theme, for: .primary, in: colorScheme, level: 5) :
                                                            themeColor(from: theme, for: .primary, in: colorScheme, level: 0)
                                                    )
                                            }
                                            .padding(16)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(
                                                selectedScreen.type == .space && settings.selectedSpaceId == space.id ?
                                                    themeColor(from: theme, for: .primary, in: colorScheme, level: 1) :
                                                    themeColor(from: theme, for: .primary, in: colorScheme, level: 3)
                                            )
                                            .cornerRadius(16)
                                            .shadow(color: theme.primary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
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
                            .frame(maxHeight: .infinity)
                        }

                        SectionView(header: "Themes") {
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(themes.filter { $0.id != theme.id }) { eachTheme in
                                        Button(action: {
                                            applyTheme(eachTheme.id)
                                        }) {
                                            Circle()
                                                .fill(eachTheme.thumbnail)
                                                .frame(width: 36, height: 36)
                                                .shadow(color: theme.primary.toShadow(opacityMultiplier: 0.8), radius: 4, y: 2)
                                                .overlay(
                                                    Circle()
                                                        .stroke(themeColor(from: theme, for: .primary, in: .light, level: 5), lineWidth: 3)
                                                        .frame(width: 33, height: 33)
                                                )
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .scrollTransition { content, phase in
                                            content
                                                .opacity(phase.isIdentity ? 1 : 0)
                                                .scaleEffect(phase.isIdentity ? 1 : 0.6)
                                                .blur(radius: phase.isIdentity ? 0 : 10)
                                        }
                                    }
                                    Button(action: {
                                        withAnimation(.spring(duration: 0.2)) {
                                            selectedScreen.type = .themeMaker
                                        }
                                    }) {
                                        Circle()
                                            .stroke(themeColor(from: theme, for: .primary, in: colorScheme, level: 1), style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [4, 6.2]))
                                            .frame(width: 33, height: 33)
                                            .contentShape(Circle())
                                            .overlay(
                                                Image(systemName: "plus")
                                                    .foregroundStyle(themeColor(from: theme, for: .primary, in: colorScheme, level: 1))
                                                    .fontWeight(.bold)
                                            )
                                            .scrollTransition { content, phase in
                                                content
                                                    .opacity(phase.isIdentity ? 1 : 0)
                                                    .scaleEffect(phase.isIdentity ? 1 : 0.6)
                                                    .blur(radius: phase.isIdentity ? 0 : 10)
                                            }
                                    }
                                }
                                .padding(16)
                            }
                            .frame(height: themesGridHeight)
                            .background(
                                themeColor(from: theme, for: .primary, in: colorScheme, level: 3)
                            )
                            .cornerRadius(16)
                            .shadow(color: theme.primary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                        }

                        Button(action: {
                            withAnimation(.spring(duration: 0.2)) {
                                selectedScreen.type = .themeMaker
                            }
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "paintpalette").font(.title2)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(
                                        selectedScreen.type == .themeMaker ? themeColor(from: theme, for: .primary, in: colorScheme, level: 4) : themeColor(from: theme, for: .primary, in: colorScheme, level: 1)
                                    )
                                Text("Theme Maker")
                                    .foregroundColor(
                                        selectedScreen.type == .themeMaker ? themeColor(from: theme, for: .primary, in: colorScheme, level: 5) : themeColor(from: theme, for: .primary, in: colorScheme, level: 0)
                                    )
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                selectedScreen.type == .themeMaker ? themeColor(from: theme, for: .primary, in: colorScheme, level: 1) : themeColor(from: theme, for: .primary, in: colorScheme, level: 3)
                            )
                            .cornerRadius(16)
                            .shadow(color: theme.primary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                        }
                    }
                    .safeAreaPadding(.horizontal, 20)
                    .safeAreaPadding(.bottom, macCatalystSpecificPadding)
                }
                .toolbar(.hidden, for: .navigationBar)
                .background(
                    LinearGradient(
                        colors: [
                            themeColor(from: theme, for: .primary, in: colorScheme, level: 4),
                            themeColor(from: theme, for: .primary, in: colorScheme, level: 5)
                        ],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
            } detail: {
                ZStack {
                    theme.mainGradient.toGradient(in: colorScheme).ignoresSafeArea()

                    switch selectedScreen.type {
                    case .themeMaker:
                        ThemeMakerView()

                    case .space:
                        if spaces.isEmpty {
                            VStack {
                                Text("Tap to create a Space!")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .themedForeground(using: theme, in: colorScheme, category: .secondary)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                addSpace()
                            }
                        } else {
                            SpaceView()
                        }

                    default:
                        EmptyView()
                    }
                }
                .toolbar(.hidden, for: .navigationBar)
                .accentColor(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
            }
            .accentColor(themeColor(from: theme, for: .primary, in: colorScheme, level: 0))

            Button(action: {
                withAnimation(.spring(duration: 0.3)) {
                    if columnVisibility == .detailOnly {
                        columnVisibility = .doubleColumn
                    } else {
                        columnVisibility = .detailOnly
                    }
                }
            }) {
                Image(systemName: "sidebar.leading")
                    .font(.system(size: 24))
                    .padding(16)
                    .foregroundColor(columnVisibility == .detailOnly ? themeColor(from: theme, for: .secondary, in: colorScheme, level: 0) : themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
            }
            .position(x: columnVisibility == .detailOnly ? 36 : 32, y: 24)

            PopUpView().ignoresSafeArea()
        }
    }

    private var themesGridHeight: CGFloat {
        let filteredThemes = themes.filter { $0.id != theme.id }
        let numberOfItems = filteredThemes.count + 1
        let rows = ceil(CGFloat(numberOfItems) / 5)
        let totalItemHeight = CGFloat(rows) * 36
        let totalSpacing = CGFloat(Int(rows) + 1) * 16
        let requiredHeight = totalItemHeight + totalSpacing
        return min(requiredHeight, maxThemesGridHeight)
    }

    private func applyTheme(_ id: UUID?) {
        guard let id = id,
              let matchingTheme = themes.first(where: { $0.id == id })
        else {
            return
        }
        guard matchingTheme.id != theme.id else { return }
        let copiedTheme = matchingTheme.deepCopy()
        theme.primary = copiedTheme.primary
        theme.secondary = copiedTheme.secondary
        theme.tertiary = copiedTheme.tertiary
        theme.mainGradient = copiedTheme.mainGradient
    }

    private func addSpace() {
        let newSpace = Space()
        modelContext.insert(newSpace)
        settings.selectedSpaceId = newSpace.id
    }

    private func deleteSpace(_ space: Space) {
        modelContext.delete(space)
    }

    private func deleteSpace(_ id: UUID) {
        guard let space = spaces.first(where: { $0.id == id })
        else { return }

        modelContext.delete(space)
    }

    private var macCatalystSpecificPadding: CGFloat {
        #if targetEnvironment(macCatalyst)
        20
        #else
        0
        #endif
    }
}

struct SectionView<Content: View, Trailing: View>: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    let header: String
    let trailing: Trailing?
    let content: Content

    init(header: String, @ViewBuilder trailing: () -> Trailing = { EmptyView() }, @ViewBuilder content: () -> Content) {
        self.header = header
        self.trailing = trailing()
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(header)
                    .font(.headline)
                    .themedForeground(using: theme, in: colorScheme)
                Spacer()
                trailing
            }
            .safeAreaPadding(.bottom, 5)
            content
        }
        .safeAreaPadding(.vertical, 16)
    }
}
