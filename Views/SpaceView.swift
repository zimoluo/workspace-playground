import SwiftUI

struct SpaceView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @StateObject var space = Space()

    @State private var lastDragTranslation: CGSize = .zero
    @State private var dragVelocity: CGSize = .zero
    @State private var currentZoom: CGFloat = 1.0

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

                                let newCenterX = space.cameraCenterX - incrementalTranslation.width
                                let newCenterY = space.cameraCenterY - incrementalTranslation.height

                                space.cameraCenterX = newCenterX.clamped(to: minCameraX ... maxCameraX)
                                space.cameraCenterY = newCenterY.clamped(to: minCameraY ... maxCameraY)

                                dragVelocity = incrementalTranslation
                            }
                            .onEnded { _ in
                                // Reset drag translation when gesture ends
                                lastDragTranslation = .zero
                                applyMomentum()
                            }
                    )
                    .gesture(
                        MagnifyGesture()
                            .onChanged { value in
                                let newZoom = currentZoom * value.magnification
                                space.cameraZoom = newZoom.clamped(to: 0.8 ... 1.25)
                            }
                            .onEnded { _ in
                                currentZoom = space.cameraZoom
                            }
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
