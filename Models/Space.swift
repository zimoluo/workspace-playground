import SwiftData
import SwiftUI

@Model
class Space {
    @Attribute(.unique) var id: UUID

    var dateCreated: Date
    var dateModified: Date

    var windows: [Window]

    var cameraCenterX: CGFloat
    var cameraCenterY: CGFloat
    var cameraZoom: CGFloat

    init(windows: [Window] = [], cameraCenterX: CGFloat = 0, cameraCenterY: CGFloat = 0, cameraZoom: CGFloat = 1) {
        self.id = UUID()
        self.dateCreated = Date()
        self.dateModified = Date()

        self.windows = windows
        self.cameraCenterX = cameraCenterX
        self.cameraCenterY = cameraCenterY
        self.cameraZoom = cameraZoom
    }
}
