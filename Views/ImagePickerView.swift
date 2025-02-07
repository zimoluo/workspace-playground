import ImagePlayground
import PhotosUI
import SwiftData
import SwiftUI

struct ImagePickerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var storedImages: [StoredImage]

    @Environment(\.supportsImagePlayground) private var supportsImagePlayground

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var savedImageID: UUID?
    @State private var isShowingCamera: Bool = false
    @State private var isShowingImagePlayground: Bool = false

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
                            isShowingCamera = true
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
        .sheet(isPresented: $isShowingCamera) {
            CameraPicker { image in
                if let image = image {
                    saveImage(image)
                }
                isShowingCamera = false
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
        .onDisappear {
            removeSavedImage()
        }
    }

    private func saveImage(_ image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let newImage = StoredImage(data)
            modelContext.insert(newImage)
            savedImageID = newImage.id
        }
    }

    private func removeSavedImage() {
        if let savedID = savedImageID,
           let storedImage = storedImages.first(where: { $0.id == savedID })
        {
            modelContext.delete(storedImage)
        }
    }
}

struct CameraPicker: UIViewControllerRepresentable {
    var completion: (UIImage?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(completion: completion)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var completion: (UIImage?) -> Void

        init(completion: @escaping (UIImage?) -> Void) {
            self.completion = completion
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
        {
            let image = info[.originalImage] as? UIImage
            completion(image)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            completion(nil)
        }
    }
}
