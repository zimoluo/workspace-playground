import SwiftUI

struct SpaceView: View {
    @StateObject var space = Space()
    @State private var lastDragTranslation: CGSize = .zero

    var body: some View {
        GeometryReader { geometry in
            space.renderDots(viewSize: geometry.size)
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

                            space.cameraCenterX = newCenterX
                            space.cameraCenterY = newCenterY
                        }
                        .onEnded { _ in
                            lastDragTranslation = .zero
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let newZoom = space.cameraZoom * value
                            space.cameraZoom = newZoom
                        }
                )
        }
        .ignoresSafeArea()
    }
}
