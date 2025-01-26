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

    @State private var menuPillDirection: Direction = .top
    @State private var isWindowMenuOpen: Bool = false

    enum Direction {
        case top, bottom, leading, trailing
    }

    let menuButtonDiameter: CGFloat = 64
    let menuPillPadding: CGFloat = 8
    let menuPillExtendedLength: CGFloat = 420

    var menuPillWidth: CGFloat {
        menuButtonDiameter + 2 * menuPillPadding
    }

    var menuPillPositionOffset: CGFloat {
        (menuPillExtendedLength - menuPillWidth) / 2
    }

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
        GeometryReader { geometry in
            ZStack {
                space.renderDots(viewSize: geometry.size, color: colorScheme == .light ? theme.secondary.shadeMap(numShades: 19).shadeMap[7].color : theme.secondary.shadeMap(numShades: 19).shadeMap[5].color)

                Color.clear
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let incrementalTranslation = CGSize(
                                    width: value.translation.width - lastDragTranslation.width,
                                    height: value.translation.height - lastDragTranslation.height
                                )
                                lastDragTranslation = value.translation

                                let newCenterX = space.cameraCenterX - incrementalTranslation.width * pow(space.cameraZoom, 0.15)
                                let newCenterY = space.cameraCenterY - incrementalTranslation.height * pow(space.cameraZoom, 0.15)

                                space.cameraCenterX = newCenterX.clamped(to: minCameraCenterX ... maxCameraCenterX)
                                space.cameraCenterY = newCenterY.clamped(to: minCameraCenterY ... maxCameraCenterY)

                                dragVelocity = incrementalTranslation
                            }
                            .onEnded { _ in
                                lastDragTranslation = .zero
                                applyMomentum()
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
                                }

                                let newZoom = currentZoom * zoomFactor
                                let clampedZoom = newZoom.clamped(to: 0.75 ... 4 / 3)

                                let adjustedCenterX = initialCameraCenter.x + (initialPinchPoint.x / currentZoom - initialPinchPoint.x / clampedZoom)
                                let adjustedCenterY = initialCameraCenter.y + (initialPinchPoint.y / currentZoom - initialPinchPoint.y / clampedZoom)

                                space.cameraZoom = clampedZoom
                                space.cameraCenterX = adjustedCenterX.clamped(to: minCameraCenterX ... maxCameraCenterX)
                                space.cameraCenterY = adjustedCenterY.clamped(to: minCameraCenterY ... maxCameraCenterY)
                            }
                            .onEnded { _ in
                                currentZoom = space.cameraZoom
                                initialPinchPoint = .zero
                            }
                    )

                WindowsOverlayView(
                    space: space,
                    parentSize: geometry.size
                )

                VStack {
                    HStack(spacing: 24) {
                        Spacer()

                        TextField("", text: Binding(
                            get: { space.name },
                            set: { newValue in
                                space.name = newValue
                            }
                        ),
                        prompt: Text("Name...").foregroundColor(themeColor(from: theme, for: .tertiary, in: colorScheme, level: 2).opacity(0.67)))
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
                            .background(isNameEditing ? themeColor(from: theme, for: .tertiary, in: colorScheme, level: 4) : .clear)
                            .safeAreaPadding(.horizontal, 16)
                            .safeAreaPadding(.vertical, 12)
                            .frame(maxWidth: 200)
                            .cornerRadius(16)
                            .shadow(color: theme.tertiary.toShadow(), radius: 8, y: 4)
                            .padding(.trailing, isNameEditing ? 16 : 0)

                        Button(action: {
                            withAnimation(.spring(duration: 0.5)) {
                                space.clusterWindows()
                            }
                        }) {
                            Image(systemName: "wand.and.stars")
                                .font(.title2)
                                .themedForeground(using: theme, in: colorScheme, category: .tertiary)
                                .shadow(color: theme.tertiary.toShadow(), radius: 8, y: 4)
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
                        }
                    }
                    .safeAreaPadding(.horizontal, 20)
                    .safeAreaPadding(.vertical, 24)

                    Spacer()
                }

                Group {
                    ZStack {
                        RoundedRectangle(cornerRadius: menuPillWidth / 2)
                            .fill(themeColor(from: theme, for: .tertiary, in: colorScheme, level: 4))
                    }
                    .shadow(color: theme.tertiary.toShadow(), radius: 12, y: 8)
                    .frame(width: isWindowMenuOpen ? (menuPillDirection == .trailing || menuPillDirection == .leading ? menuPillExtendedLength : menuPillWidth) : menuButtonDiameter,
                           height: isWindowMenuOpen ? (menuPillDirection == .top || menuPillDirection == .bottom ? menuPillExtendedLength : menuPillWidth) : menuButtonDiameter)
                    .offset(x: isWindowMenuOpen ? (menuPillDirection == .trailing ? menuPillPositionOffset : menuPillDirection == .leading ? -menuPillPositionOffset : 0) : 0, y: isWindowMenuOpen ? (menuPillDirection == .bottom ? menuPillPositionOffset : menuPillDirection == .top ? -menuPillPositionOffset : 0) : 0)

                    Button(action: {
                        withAnimation(.spring(duration: 0.3)) {
                            isWindowMenuOpen.toggle()
                        }
                    }) {
                        Image(systemName: "plus")
                            .rotationEffect(.degrees(isWindowMenuOpen ? 45 : 0))
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(themeColor(from: theme, for: .tertiary, in: colorScheme, level: 1))
                            .frame(width: menuButtonDiameter, height: menuButtonDiameter)
                            .background(
                                Circle()
                                    .fill(themeColor(from: theme, for: .tertiary, in: colorScheme, level: 5))
                                    .shadow(color: theme.tertiary.toShadow(opacityMultiplier: 0.8), radius: 8, y: 6)
                            )
                    }
                }
                .position(x: geometry.size.width - 68, y: geometry.size.height - 68)
            }
        }
        .ignoresSafeArea()
    }

    private func applyMomentum() {
        let deceleration: CGFloat = 0.885
        let minVelocity: CGFloat = 0.1

        var displayLink: CADisplayLink?

        displayLink = CADisplayLink(target: BlockOperation {
            dragVelocity = CGSize(
                width: dragVelocity.width * deceleration,
                height: dragVelocity.height * deceleration
            )

            space.cameraCenterX = (space.cameraCenterX - dragVelocity.width).clamped(to: minCameraCenterX ... maxCameraCenterX)
            space.cameraCenterY = (space.cameraCenterY - dragVelocity.height).clamped(to: minCameraCenterY ... maxCameraCenterY)

            if abs(dragVelocity.width) <= minVelocity && abs(dragVelocity.height) <= minVelocity {
                displayLink?.invalidate()
                displayLink = nil
            }
        }, selector: #selector(Operation.main))

        displayLink?.add(to: .current, forMode: .common)
    }
}
