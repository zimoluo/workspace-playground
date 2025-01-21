import SwiftUI

struct WindowsOverlayView: View {
    @ObservedObject var space: Space
    let parentSize: CGSize

    var body: some View {
        ZStack {
            ForEach($space.windows, id: \.id) { $window in
                WindowView(window: $window, space: space, parentSize: parentSize)
            }
        }
    }
}
