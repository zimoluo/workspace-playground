import SwiftData
import SwiftUI

@Model
class StoredImage {
    @Attribute(.unique) var id: UUID
    var imageData: Data

    init(_ imageData: Data) {
        self.id = UUID()
        self.imageData = imageData
    }
}
