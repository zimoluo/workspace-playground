import ImagePlayground
import PhotosUI
import SwiftData
import SwiftUI

struct ImagePickerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var storedImages: [StoredImage]
    @Query private var spaces: [Space]

    @Environment(\.supportsImagePlayground) private var supportsImagePlayground
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var isShowingImagePlayground: Bool = false

    private var savedImageID: UUID? {
        if let idString = space.windows.first(where: { $0.id == windowId })?.data.saveData["savedImageID"],
           let uuid = UUID(uuidString: idString)
        {
            return uuid
        }
        return nil
    }

    var body: some View {
        ZStack {
            if let savedID = savedImageID,
               let storedImage = storedImages.first(where: { $0.id == savedID }),
               let uiImage = UIImage(data: storedImage.imageData)
            {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .allowsHitTesting(false)
            } else {
                VStack {
                    HStack(spacing: 8) {
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            VStack {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 32, weight: .medium))
                                    .frame(width: 36, height: 36)
                                Text("Photos")
                                    .font(.system(size: 16, weight: .medium))
                            }
                        }
                        .gesture(DragGesture().onChanged { _ in })
                        .frame(width: 96)

                        Button(action: {
                            // camera is disabled in Swift Playgrounds so we'll just leave it here for fun.
                        }) {
                            VStack {
                                Image(systemName: "camera")
                                    .font(.system(size: 32, weight: .medium))
                                    .frame(width: 36, height: 36)
                                Text("Camera")
                                    .font(.system(size: 16, weight: .medium))
                            }
                        }
                        .gesture(DragGesture().onChanged { _ in })
                        .frame(width: 96)
                        .opacity(0.5)
                        .disabled(true)

                        if supportsImagePlayground {
                            Button(action: {
                                isShowingImagePlayground = true
                            }) {
                                VStack {
                                    Image(systemName: "apple.image.playground")
                                        .font(.system(size: 32, weight: .medium))
                                        .frame(width: 36, height: 36)
                                    Text("Playground")
                                        .font(.system(size: 16, weight: .medium))
                                }
                            }
                            .gesture(DragGesture().onChanged { _ in })
                            .frame(width: 96)
                        }
                    }
                }
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.75))
            }
        }
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data)
                {
                    saveImage(uiImage)
                }
            }
        }
        .imagePlaygroundSheet(
            isPresented: $isShowingImagePlayground,
            concept: space.name,
            sourceImage: nil,
            onCompletion: { url in
                if let data = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: data)
                {
                    saveImage(uiImage)
                }
            },
            onCancellation: {
                isShowingImagePlayground = false
            }
        )
    }

    private func saveImage(_ image: UIImage) {
        cleanupUnusedImages()

        let resizedImage = resizeImageIfNeeded(image, maxSideLength: 640)

        if let data = resizedImage.jpegData(compressionQuality: 0.8) {
            let newImage = StoredImage(data)

            if let windowIndex = space.windows.firstIndex(where: { $0.id == windowId }) {
                modelContext.insert(newImage)
                space.windows[windowIndex].data.saveData["savedImageID"] = newImage.id.uuidString
                space.windows[windowIndex].data.minWidth = 100
                space.windows[windowIndex].data.minHeight = 100
                space.windows[windowIndex].data.maxWidth = max(100, resizedImage.size.width)
                space.windows[windowIndex].data.maxHeight = max(100, resizedImage.size.height)
                space.windows[windowIndex].state.width = max(100, resizedImage.size.width * 0.75)
                space.windows[windowIndex].state.height = max(100, resizedImage.size.height * 0.75)
            }
        }
    }

    private func resizeImageIfNeeded(_ image: UIImage, maxSideLength: CGFloat) -> UIImage {
        let width = image.size.width
        let height = image.size.height
        let maxDimension = max(width, height)

        guard maxDimension > maxSideLength else { return image }

        let scaleFactor = maxSideLength / maxDimension
        let newSize = CGSize(width: width * scaleFactor, height: height * scaleFactor)

        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage ?? image
    }

    private func cleanupUnusedImages() {
        let activeImageIDs = spaces
            .flatMap { $0.windows }
            .filter { $0.data.type == .image }
            .compactMap { $0.data.saveData["savedImageID"] }
            .compactMap(UUID.init)

        let unusedImages = storedImages.filter { !activeImageIDs.contains($0.id) }

        for image in unusedImages {
            modelContext.delete(image)
        }
    }
}
