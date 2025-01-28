import SwiftData
import SwiftUI

struct SpaceView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Space.dateModified, order: .reverse) var spaces: [Space]
    @Environment(\.settings) private var settings
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var space: Space {
        spaces.first(where: { $0.id == settings.selectedSpaceId }) ?? Space()
    }

    @State private var isNameEditing: Bool = false
    @FocusState private var focusedField: FocusField?

    enum FocusField: Hashable {
        case name
    }

    var isWindowMenuOpen: Bool {
        settings.isWindowsMenuButtonExpanded
    }

    static let menuButtonDiameter: CGFloat = 64
    static let menuPillPadding: CGFloat = 12
    static let menuPillExtendedLength: CGFloat = 420

    static var menuPillWidth: CGFloat {
        menuButtonDiameter + 2 * menuPillPadding
    }

    static var menuPillPositionOffset: CGFloat {
        (menuPillExtendedLength - menuPillWidth) / 2
    }

    @State private var menuDragOffset: CGSize = .zero

    @State private var isDragging: Bool = false
    @State private var lastDragTranslation: CGSize = .zero
    @State private var dragVelocity: CGSize = .zero
    @State private var currentZoom: CGFloat = 1.0

    @State private var initialPinchPoint: CGPoint = .zero
    @State private var initialCameraCenter: CGPoint = .zero

    private var maxCameraCenterX: CGFloat {
        let maxRightEdge = space.windows.map { $0.state.x + $0.state.width / 2 }.max() ?? 0
        let calculatedMax = max(maxRightEdge + 150, 300)
        return min(calculatedMax, 1_000_000_000)
    }

    private var minCameraCenterX: CGFloat {
        let minLeftEdge = space.windows.map { $0.state.x - $0.state.width / 2 }.min() ?? 0
        let calculatedMin = min(minLeftEdge - 150, -300)
        return max(calculatedMin, -1_000_000_000)
    }

    private var maxCameraCenterY: CGFloat {
        let maxBottomEdge = space.windows.map { $0.state.y + $0.state.height / 2 }.max() ?? 0
        let calculatedMax = max(maxBottomEdge + 150, 300)
        return min(calculatedMax, 1_000_000_000)
    }

    private var minCameraCenterY: CGFloat {
        let minTopEdge = space.windows.map { $0.state.y - $0.state.height / 2 }.min() ?? 0
        let calculatedMin = min(minTopEdge - 150, -300)
        return max(calculatedMin, -1_000_000_000)
    }

    var body: some View {
        if spaces.isEmpty || spaces.first == nil {
            EmptyView()
        } else {
            GeometryReader { geometry in
                ZStack {
                    if !space.disableDots {
                        space.renderDots(
                            viewSize: geometry.size,
                            color: colorScheme == .light
                                ? theme.secondary.shadeMap(numShades: 19).shadeMap[7].color
                                : theme.secondary.shadeMap(numShades: 19).shadeMap[5].color
                        )
                    }

                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if !isDragging {
                                        isDragging = true
                                    }

                                    let incrementalTranslation = CGSize(
                                        width: value.translation.width - lastDragTranslation.width,
                                        height: value.translation.height - lastDragTranslation.height
                                    )
                                    lastDragTranslation = value.translation

                                    let zoomFactor = 1.0 / space.cameraZoom
                                    let newCenterX = space.cameraCenterX - incrementalTranslation.width * zoomFactor
                                    let newCenterY = space.cameraCenterY - incrementalTranslation.height * zoomFactor

                                    space.cameraCenterX = newCenterX.clamped(to: minCameraCenterX ... maxCameraCenterX)
                                    space.cameraCenterY = newCenterY.clamped(to: minCameraCenterY ... maxCameraCenterY)

                                    dragVelocity = incrementalTranslation
                                }
                                .onEnded { _ in
                                    lastDragTranslation = .zero
                                    isDragging = false
                                    applyMomentum()
                                    space.updateDateModified()
                                }
                        )
                        .gesture(
                            MagnifyGesture()
                                .onChanged { value in
                                    if dragVelocity != .zero {
                                        dragVelocity = .zero
                                    }

                                    let zoomFactor = value.magnification

                                    if initialPinchPoint == .zero {
                                        initialPinchPoint = CGPoint(
                                            x: value.startLocation.x - geometry.size.width / 2,
                                            y: value.startLocation.y - geometry.size.height / 2
                                        )
                                        initialCameraCenter = CGPoint(
                                            x: space.cameraCenterX,
                                            y: space.cameraCenterY
                                        )

                                        currentZoom = space.cameraZoom
                                    }

                                    let newZoom = currentZoom * zoomFactor
                                    let clampedZoom = newZoom.clamped(to: 2 / 3 ... 1.5)

                                    let deltaX = initialPinchPoint.x / currentZoom - initialPinchPoint.x / clampedZoom
                                    let deltaY = initialPinchPoint.y / currentZoom - initialPinchPoint.y / clampedZoom

                                    let adjustedCenterX = initialCameraCenter.x + deltaX
                                    let adjustedCenterY = initialCameraCenter.y + deltaY

                                    space.cameraZoom = clampedZoom
                                    space.cameraCenterX = adjustedCenterX.clamped(to: minCameraCenterX ... maxCameraCenterX)
                                    space.cameraCenterY = adjustedCenterY.clamped(to: minCameraCenterY ... maxCameraCenterY)
                                }
                                .onEnded { _ in
                                    currentZoom = space.cameraZoom
                                    initialPinchPoint = .zero
                                    space.updateDateModified()
                                }
                        )

                    WindowsOverlayView(
                        space: space,
                        parentSize: geometry.size
                    )

                    VStack {
                        HStack(spacing: 0) {
                            Spacer()

                            TextField(
                                "",
                                text: Binding(
                                    get: { space.name },
                                    set: { newValue in space.name = newValue }
                                ),
                                prompt: Text("Name...")
                                    .foregroundColor(
                                        themeColor(from: theme, for: .tertiary, in: colorScheme, level: 2)
                                            .opacity(0.67)
                                    )
                            )
                            .focused($focusedField, equals: .name)
                            .onChange(of: focusedField) {
                                withAnimation(.spring(duration: 0.3)) {
                                    if focusedField == .name {
                                        isNameEditing = true
                                    } else {
                                        isNameEditing = false
                                    }
                                }
                            }
                            .font(.headline)
                            .multilineTextAlignment(.trailing)
                            .themedForeground(using: theme, in: colorScheme, category: .tertiary)
                            .background(
                                isNameEditing
                                    ? themeColor(from: theme, for: .tertiary, in: colorScheme, level: 5)
                                    : .clear
                            )
                            .safeAreaPadding(.horizontal, 16)
                            .safeAreaPadding(.vertical, 12)
                            .frame(maxWidth: 160)
                            .cornerRadius(16)
                            .shadow(color: theme.tertiary.toShadow(), radius: 8, y: 4)
                            .padding(.trailing, isNameEditing ? 16 : 0)

                            Button(action: {
                                withAnimation(.spring(duration: 0.5)) {
                                    space.disableDots.toggle()
                                    space.updateDateModified()
                                }
                            }) {
                                ZStack {
                                    Image(systemName: "square")
                                        .font(.title2)
                                        .themedForeground(using: theme, in: colorScheme, category: .tertiary)
                                        .shadow(color: theme.tertiary.toShadow(), radius: 8, y: 4)
                                    Image(systemName: "square.grid.3x3.square")
                                        .font(.title2)
                                        .themedForeground(using: theme, in: colorScheme, category: .tertiary)
                                        .opacity(space.disableDots ? 0.33 : 1)
                                }
                                .safeAreaPadding(.horizontal, 12)
                                .safeAreaPadding(.vertical, 12)
                            }

                            Button(action: {
                                withAnimation(.spring(duration: 0.5)) {
                                    space.clusterWindows()
                                }
                            }) {
                                Image(systemName: "rectangle.3.group")
                                    .font(.title2)
                                    .themedForeground(using: theme, in: colorScheme, category: .tertiary)
                                    .shadow(color: theme.tertiary.toShadow(), radius: 8, y: 4)
                                    .safeAreaPadding(.horizontal, 12)
                                    .safeAreaPadding(.vertical, 12)
                            }

                            Button(action: {
                                withAnimation(.spring(duration: 0.2)) {
                                    let newSpace = Space()
                                    modelContext.insert(newSpace)
                                    settings.selectedSpaceId = newSpace.id
                                }
                            }) {
                                Image(systemName: "square.and.pencil")
                                    .font(.title2)
                                    .themedForeground(using: theme, in: colorScheme, category: .tertiary)
                                    .shadow(color: theme.tertiary.toShadow(), radius: 8, y: 4)
                                    .safeAreaPadding(.horizontal, 12)
                                    .safeAreaPadding(.vertical, 12)
                            }
                        }
                        .safeAreaPadding(.horizontal, 8)
                        .safeAreaPadding(.vertical, 24)

                        Spacer()
                    }

                    let anchor = menuAnchorPosition(
                        for: settings.windowsMenuButtonsPosition,
                        in: geometry.size
                    )

                    WindowMenuView(
                        space: space
                    )
                    .position(x: anchor.x + menuDragOffset.width, y: anchor.y + menuDragOffset.height)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                menuDragOffset = value.translation
                            }
                            .onEnded { value in
                                let predictedTranslation = value.predictedEndTranslation
                                let predictedX = anchor.x + predictedTranslation.width
                                let predictedY = anchor.y + predictedTranslation.height
                                let predictedPosition = CGPoint(x: predictedX, y: predictedY)

                                let newPosition = nearestMenuPosition(
                                    for: predictedPosition,
                                    in: geometry.size
                                )

                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    menuDragOffset = .zero
                                    settings.windowsMenuButtonsPosition = newPosition
                                }
                            }
                    )
                }
            }
            .ignoresSafeArea()
        }
    }

    private func applyMomentum() {
        let deceleration: CGFloat = 0.905
        let minVelocity: CGFloat = 0.1

        var displayLink: CADisplayLink?

        displayLink = CADisplayLink(target: BlockOperation {
            guard !isDragging else {
                displayLink?.invalidate()
                return
            }

            dragVelocity = CGSize(
                width: dragVelocity.width * deceleration,
                height: dragVelocity.height * deceleration
            )

            space.cameraCenterX = (space.cameraCenterX - dragVelocity.width)
                .clamped(to: minCameraCenterX ... maxCameraCenterX)
            space.cameraCenterY = (space.cameraCenterY - dragVelocity.height)
                .clamped(to: minCameraCenterY ... maxCameraCenterY)

            if abs(dragVelocity.width) <= minVelocity && abs(dragVelocity.height) <= minVelocity {
                displayLink?.invalidate()
            }
        }, selector: #selector(Operation.main))

        displayLink?.add(to: .current, forMode: .common)
    }

    private func menuAnchorPosition(
        for position: WindowsMenuButtonPosition,
        in size: CGSize
    ) -> CGPoint {
        let offset: CGFloat = 72
        let menuPillOffset: CGFloat = SpaceView.menuPillPositionOffset
        let computedOffsetCenter: CGFloat = -offset - SpaceView.menuPillExtendedLength + SpaceView.menuPillWidth

        switch position {
        case .bottomTrailing:
            return CGPoint(x: size.width - offset, y: size.height - offset)
        case .bottomLeading:
            return CGPoint(x: offset, y: size.height - offset)
        case .leading:
            return CGPoint(x: offset, y: min(size.height / 2, size.height + computedOffsetCenter))
        case .trailing:
            return CGPoint(x: size.width - offset, y: min(size.height / 2, size.height + computedOffsetCenter))
        case .bottomCenterLeading:
            return CGPoint(
                x: size.width / 2 - menuPillOffset,
                y: size.height - offset
            )
        case .bottomCenterTrailing:
            return CGPoint(
                x: size.width / 2 + menuPillOffset,
                y: size.height - offset
            )
        }
    }

    private func nearestMenuPosition(
        for point: CGPoint,
        in size: CGSize
    ) -> WindowsMenuButtonPosition {
        let candidates: [WindowsMenuButtonPosition] = [
            .bottomTrailing, .bottomLeading,
            .leading, .trailing,
            .bottomCenterLeading, .bottomCenterTrailing
        ]

        var bestPosition = candidates.first!
        var bestDistance = CGFloat.greatestFiniteMagnitude

        for candidate in candidates {
            let anchorPoint = menuAnchorPosition(for: candidate, in: size)
            let dx = anchorPoint.x - point.x
            let dy = anchorPoint.y - point.y
            let distance = (dx * dx + dy * dy).squareRoot()
            if distance < bestDistance {
                bestDistance = distance
                bestPosition = candidate
            }
        }

        return bestPosition
    }
}

struct WindowMenuView: View {
    @Environment(\.settings) private var settings

    var isWindowMenuOpen: Bool {
        settings.isWindowsMenuButtonExpanded
    }

    var menuPillDirection: WindowsMenuDirection {
        settings.windowsMenuButtonsPosition.menuDirection
    }

    let menuButtonDiameter: CGFloat = SpaceView.menuButtonDiameter
    let menuPillPadding: CGFloat = SpaceView.menuPillPadding
    let menuPillExtendedLength: CGFloat = SpaceView.menuPillExtendedLength

    var menuPillWidth: CGFloat = SpaceView.menuPillWidth

    var menuPillPositionOffset: CGFloat = SpaceView.menuPillPositionOffset

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var space: Space

    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: isWindowMenuOpen ? 16 : menuPillWidth / 2)
                    .fill(themeColor(from: theme, for: .tertiary, in: colorScheme, level: 4))
                    .opacity(isWindowMenuOpen ? 1 : 0)

                ZStack {
                    RoundedRectangle(cornerRadius: isWindowMenuOpen ? 16 : menuPillWidth / 2)
                        .fill(themeColor(from: theme, for: .tertiary, in: colorScheme, level: 5))
                        .frame(maxWidth: isWindowMenuOpen ? .infinity : menuButtonDiameter, maxHeight: isWindowMenuOpen ? .infinity : menuButtonDiameter)
                        .opacity(isWindowMenuOpen ? 1 : 0)

                    let itemColor = themeColor(from: theme, for: .tertiary, in: colorScheme, level: 1)

                    if menuPillDirection == .top || menuPillDirection == .bottom {
                        ScrollView(.vertical) {
                            LazyVStack(spacing: 36) {
                                windowTypeButtons(itemColor: itemColor)
                            }
                            .safeAreaPadding(.vertical, 24)
                        }
                        .opacity(isWindowMenuOpen ? 1 : 0)
                    } else {
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 36) {
                                windowTypeButtons(itemColor: itemColor)
                            }
                            .safeAreaPadding(.horizontal, 24)
                        }
                        .opacity(isWindowMenuOpen ? 1 : 0)
                    }
                }
                .padding(EdgeInsets(
                    top: isWindowMenuOpen ? (menuPillDirection == .bottom ? menuPillWidth : menuPillPadding) : 0,
                    leading: isWindowMenuOpen ? (menuPillDirection == .trailing ? menuPillWidth : menuPillPadding) : 0,
                    bottom: isWindowMenuOpen ? (menuPillDirection == .top ? menuPillWidth : menuPillPadding) : 0,
                    trailing: isWindowMenuOpen ? (menuPillDirection == .leading ? menuPillWidth : menuPillPadding) : 0
                ))
            }
            .shadow(color: isWindowMenuOpen ? theme.tertiary.toShadow() : .clear, radius: 12, y: 8)
            .frame(
                width: isWindowMenuOpen
                    ? (menuPillDirection == .trailing || menuPillDirection == .leading ? menuPillExtendedLength : menuPillWidth)
                    : menuButtonDiameter,
                height: isWindowMenuOpen
                    ? (menuPillDirection == .top || menuPillDirection == .bottom ? menuPillExtendedLength : menuPillWidth)
                    : menuButtonDiameter
            )
            .offset(
                x: isWindowMenuOpen
                    ? (menuPillDirection == .trailing ? menuPillPositionOffset : menuPillDirection == .leading ? -menuPillPositionOffset : 0)
                    : 0,
                y: isWindowMenuOpen
                    ? (menuPillDirection == .bottom ? menuPillPositionOffset : menuPillDirection == .top ? -menuPillPositionOffset : 0)
                    : 0
            )

            Image(systemName: "plus")
                .rotationEffect(.degrees(isWindowMenuOpen ? 45 : 0))
                .font(.system(size: 30, weight: .semibold))
                .foregroundColor(
                    themeColor(from: theme, for: .tertiary, in: colorScheme, level: 1)
                )
                .frame(width: menuButtonDiameter, height: menuButtonDiameter)
                .background(
                    RoundedRectangle(cornerRadius: isWindowMenuOpen ? 16 : menuPillWidth / 2)
                        .fill(
                            themeColor(from: theme, for: .tertiary, in: colorScheme, level: 5)
                        )
                        .shadow(
                            color: theme.tertiary.toShadow(opacityMultiplier: 0.8),
                            radius: 8,
                            y: 6
                        )
                )
                .onTapGesture {
                    withAnimation(.spring(duration: 0.3)) {
                        settings.isWindowsMenuButtonExpanded.toggle()
                    }
                }
        }
    }

    @ViewBuilder
    private func windowTypeButtons(itemColor: Color) -> some View {
        ForEach(WindowType.allCases, id: \.self) { windowType in
            Button(action: {
                withAnimation(.spring(duration: 0.3)) {
                    space.addWindow(type: windowType)
                }
            }) {
                if windowType.glyph.mode == .system {
                    Image(systemName: windowType.glyph.key)
                        .font(.system(size: 32))
                        .foregroundColor(itemColor)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0)
                                .scaleEffect(phase.isIdentity ? 1 : 0.6)
                                .blur(radius: phase.isIdentity ? 0 : 10)
                        }
                } else {
                    Image(windowType.glyph.key)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(itemColor)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0)
                                .scaleEffect(phase.isIdentity ? 1 : 0.6)
                                .blur(radius: phase.isIdentity ? 0 : 10)
                        }
                }
            }
        }
    }
}
