import SwiftUI

struct SpaceView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @StateObject var space = Space()

    @State private var lastDragTranslation: CGSize = .zero
    @State private var dragVelocity: CGSize = .zero
    @State private var currentZoom: CGFloat = 1.0

    @State private var initialPinchPoint: CGPoint = .zero
    @State private var initialCameraCenter: CGPoint = .zero

    private var maxCameraX: CGFloat = 200
    private var maxCameraY: CGFloat = 200
    private var minCameraX: CGFloat = -200
    private var minCameraY: CGFloat = -200

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

                                let newCenterX = space.cameraCenterX - incrementalTranslation.width * sqrt(space.cameraZoom)
                                let newCenterY = space.cameraCenterY - incrementalTranslation.height * sqrt(space.cameraZoom)

                                space.cameraCenterX = newCenterX.clamped(to: minCameraX ... maxCameraX)
                                space.cameraCenterY = newCenterY.clamped(to: minCameraY ... maxCameraY)

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
                                let clampedZoom = newZoom.clamped(to: 0.8 ... 1.25)

                                let adjustedCenterX = initialCameraCenter.x + (initialPinchPoint.x / currentZoom - initialPinchPoint.x / clampedZoom)
                                let adjustedCenterY = initialCameraCenter.y + (initialPinchPoint.y / currentZoom - initialPinchPoint.y / clampedZoom)

                                space.cameraZoom = clampedZoom
                                space.cameraCenterX = adjustedCenterX.clamped(to: minCameraX ... maxCameraX)
                                space.cameraCenterY = adjustedCenterY.clamped(to: minCameraY ... maxCameraY)
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

            space.cameraCenterX = (space.cameraCenterX - dragVelocity.width).clamped(to: minCameraX ... maxCameraX)
            space.cameraCenterY = (space.cameraCenterY - dragVelocity.height).clamped(to: minCameraY ... maxCameraY)

            if abs(dragVelocity.width) < minVelocity && abs(dragVelocity.height) < minVelocity {
                timer.invalidate()
            }
        }
    }
}
