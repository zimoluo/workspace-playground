import SwiftUI

struct RichTextEditor: UIViewRepresentable {
    @Binding var text: NSAttributedString

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.delegate = context.coordinator

        textView.allowsEditingTextAttributes = true
        textView.isUserInteractionEnabled = true
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.attributedText != text {
            let selectedRange = uiView.selectedRange
            uiView.attributedText = text
            uiView.selectedRange = selectedRange
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: RichTextEditor

        init(_ parent: RichTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.attributedText
        }
    }
}

struct RichTextEditorView: View {
    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        let window = space.windows.first { $0.id == windowId }
        let key = "richTextEditorKey"

        let initialText: NSAttributedString = {
            if let dataString = window?.data.saveData[key],
               let data = Data(base64Encoded: dataString),
               let attributedString = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSAttributedString.self, from: data)
            {
                return attributedString
            } else {
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 18),
                    .foregroundColor: UIColor(.accentColor)
                ]
                return NSAttributedString(string: "Start typing here...", attributes: attributes)
            }
        }()

        RichTextEditor(text: Binding<NSAttributedString>(
            get: {
                initialText
            },
            set: { newValue in
                guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false) else {
                    return
                }
                let base64String = encodedData.base64EncodedString()

                if let index = space.windows.firstIndex(where: { $0.id == windowId }) {
                    space.windows[index].data.saveData[key] = base64String
                }
            }
        ))
        .padding(16)
        .background(.clear)
        .cornerRadius(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    RichTextEditorView()
}
