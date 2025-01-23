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

    @State private var lastDragTranslation: CGSize = .zero
    @State private var dragVelocity: CGSize = .zero
    @State private var currentZoom: CGFloat = 1.0

    @State private var initialPinchPoint: CGPoint = .zero
    @State private var initialCameraCenter: CGPoint = .zero

    private var maxCameraCenterX: CGFloat {
        let maxRightEdge = space.windows.map { $0.state.x + $0.state.width / 2 }.max() ?? 0
        let calculatedMax = max(maxRightEdge + 100, 200)
        return min(calculatedMax, 1_000_000_000)
    }

    private var minCameraCenterX: CGFloat {
        let minLeftEdge = space.windows.map { $0.state.x - $0.state.width / 2 }.min() ?? 0
        let calculatedMin = min(minLeftEdge - 100, -200)
        return max(calculatedMin, -1_000_000_000)
    }

    private var maxCameraCenterY: CGFloat {
        let maxBottomEdge = space.windows.map { $0.state.y + $0.state.height / 2 }.max() ?? 0
        let calculatedMax = max(maxBottomEdge + 100, 200)
        return min(calculatedMax, 1_000_000_000)
    }

    private var minCameraCenterY: CGFloat {
        let minTopEdge = space.windows.map { $0.state.y - $0.state.height / 2 }.min() ?? 0
        let calculatedMin = min(minTopEdge - 100, -200)
        return max(calculatedMin, -1_000_000_000)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                space.renderDots(viewSize: geometry.size, color: theme.secondary.shadeMap(numShades: 19).shadeMap[7].color)

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
                                let clampedZoom = newZoom.clamped(to: 2 / 3 ... 1.5)

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
            }
        }
        .ignoresSafeArea()
    }

    private func applyMomentum() {
        let deceleration: CGFloat = 0.885
        let minVelocity: CGFloat = 0.1

        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { timer in
            dragVelocity = CGSize(
                width: dragVelocity.width * deceleration,
                height: dragVelocity.height * deceleration
            )

            space.cameraCenterX = (space.cameraCenterX - dragVelocity.width).clamped(to: minCameraCenterX ... maxCameraCenterX)
            space.cameraCenterY = (space.cameraCenterY - dragVelocity.height).clamped(to: minCameraCenterY ... maxCameraCenterY)

            if abs(dragVelocity.width) < minVelocity && abs(dragVelocity.height) < minVelocity {
                timer.invalidate()
            }
        }
    }
}
