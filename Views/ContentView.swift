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
                                        SpaceCardView(
                                            space: space,
                                            isSelected: selectedScreen.type == .space && settings.selectedSpaceId == space.id,
                                            onTap: {
                                                withAnimation(.spring(duration: 0.1)) {
                                                    selectedScreen.type = .space
                                                    settings.selectedSpaceId = space.id
                                                }
                                            },
                                            onDelete: {
                                                deleteSpace(space)
                                            },
                                            onDuplicate: {
                                                let duplicatedSpace = space.copy()
                                                modelContext.insert(duplicatedSpace)
                                            }
                                        )
                                        .scrollTransition { content, phase in
                                            content
                                                .opacity(phase.isIdentity ? 1 : 0.5)
                                        }
                                    }
                                }
                                .animation(.spring(duration: 0.5), value: spaces)
                            }
                            .frame(maxHeight: .infinity)
                        }

                        SectionView(header: "Themes") {
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(themes.filter { $0.id != theme.id }) { eachTheme in
                                        Button(action: {
                                            withAnimation(.spring(duration: 0.2)) {
                                                applyTheme(eachTheme.id)
                                            }
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
                            .shadow(color: theme.primary.toShadow(opacityMultiplier: 0.8), radius: 8, y: 6)
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
                            .shadow(color: theme.primary.toShadow(opacityMultiplier: 0.8), radius: 8, y: 6)
                        }
                    }
                    .safeAreaPadding(.horizontal, 20)
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
                .safeAreaPadding(.top, 24)
                .safeAreaPadding(.bottom, 40)
                .ignoresSafeArea(edges: .vertical)
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
                    .foregroundColor(columnVisibility == .detailOnly ? (selectedScreen.type == .space ? themeColor(from: theme, for: .tertiary, in: colorScheme, level: 0) : themeColor(from: theme, for: .secondary, in: colorScheme, level: 0)) : themeColor(from: theme, for: .primary, in: colorScheme, level: 0))
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

    private func deleteSpace(_ id: UUID) {
        guard let index = spaces.firstIndex(where: { $0.id == id }) else { return }

        let nextIndex = index < spaces.count - 1 ? index + 1 : (index > 0 ? index - 1 : nil)
        let nextSelectedSpaceId = nextIndex != nil ? spaces[nextIndex!].id : UUID()

        if let space = spaces.first(where: { $0.id == id }) {
            modelContext.delete(space)
        }

        settings.selectedSpaceId = nextSelectedSpaceId
    }

    private func deleteSpace(_ space: Space) {
        deleteSpace(space.id)
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

struct SpaceCardView: View {
    @ObservedObject var space: Space
    let isSelected: Bool

    let onTap: () -> Void
    let onDelete: () -> Void
    let onDuplicate: () -> Void

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(space.name.isEmpty ? "New Space" : space.name)
                        .foregroundColor(isSelected ?
                            themeColor(from: theme, for: .primary, in: colorScheme, level: 5) :
                            themeColor(from: theme, for: .primary, in: colorScheme, level: 0)
                        )
                        .fontWeight(.bold)

                    Text(formattedDateString(for: space.dateModified))
                        .foregroundColor(isSelected ?
                            themeColor(from: theme, for: .primary, in: colorScheme, level: 5) :
                            themeColor(from: theme, for: .primary, in: colorScheme, level: 0)
                        )
                        .font(.subheadline)
                        .opacity(0.75)
                }

                Spacer()

                space.thumbnail(
                    canvasSize: CGSize(width: 64, height: 64),
                    color: isSelected ?
                        themeColor(from: theme, for: .primary, in: colorScheme, level: 4) :
                        themeColor(from: theme, for: .primary, in: colorScheme, level: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.leading, 16)
            .padding(.trailing, 8)
            .padding(.vertical, 8)
            .frame(height: 80)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                isSelected ?
                    themeColor(from: theme, for: .primary, in: colorScheme, level: 1) :
                    themeColor(from: theme, for: .primary, in: colorScheme, level: 3)
            )
            .cornerRadius(16)
            .shadow(color: theme.primary.toShadow(opacityMultiplier: 0.8), radius: 8, y: 6)
            .contextMenu {
                Button {
                    space.clusterWindows()
                } label: {
                    Label("Organize windows", systemImage: "rectangle.3.group")
                }

                Button {
                    onDuplicate()
                } label: {
                    Label("Duplicate", systemImage: "doc.on.doc")
                }

                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            } preview: {
                space.thumbnail(
                    canvasSize: CGSize(width: 240, height: 240),
                    color: themeColor(from: theme, for: .primary, in: colorScheme, level: 2),
                    windowCornerRadius: 12
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }

    private func formattedDateString(for date: Date, relativeTo referenceDate: Date = Date()) -> String {
        let calendar = Calendar.current
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short

        if calendar.isDateInToday(date) {
            return timeFormatter.string(from: date)
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if calendar.isDate(date, equalTo: referenceDate, toGranularity: .weekOfYear) {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter.string(from: date)
        }
    }
}
