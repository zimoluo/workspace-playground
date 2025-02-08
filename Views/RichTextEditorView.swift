import SwiftUI

extension NSAttributedString.Key {
    static let isDefaultTextColor = NSAttributedString.Key("isDefaultTextColor")
}

struct RichTextEditor: UIViewRepresentable {
    @Binding var text: NSAttributedString
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme

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
        let themeUIColor = UIColor(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.75))
        let mutableAttributedText = NSMutableAttributedString(attributedString: text)

        mutableAttributedText.enumerateAttribute(.isDefaultTextColor, in: NSRange(location: 0, length: mutableAttributedText.length), options: []) { value, range, _ in
            if let isDefault = value as? Bool, isDefault {
                mutableAttributedText.addAttribute(.foregroundColor, value: themeUIColor, range: range)
            }
        }

        if uiView.attributedText != mutableAttributedText {
            let selectedRange = uiView.selectedRange
            uiView.attributedText = mutableAttributedText
            uiView.selectedRange = selectedRange
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: RichTextEditor
        private var isUpdating = false

        init(_ parent: RichTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            guard !isUpdating else { return }
            isUpdating = true

            let themeUIColor = UIColor(themeColor(from: parent.theme, for: .secondary, in: parent.colorScheme))
            let mutableAttributedText = NSMutableAttributedString(attributedString: textView.attributedText)

            mutableAttributedText.enumerateAttribute(.foregroundColor, in: NSRange(location: 0, length: mutableAttributedText.length), options: []) { value, range, _ in
                if let color = value as? UIColor {
                    if color == themeUIColor {
                        mutableAttributedText.addAttribute(.isDefaultTextColor, value: true, range: range)
                    } else {
                        mutableAttributedText.addAttribute(.isDefaultTextColor, value: false, range: range)
                    }
                }
            }

            let selectedRange = textView.selectedRange
            textView.attributedText = mutableAttributedText
            textView.selectedRange = selectedRange
            parent.text = mutableAttributedText

            isUpdating = false
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
                    .font: UIFont.systemFont(ofSize: 20),
                    .foregroundColor: UIColor(themeColor(from: theme, for: .secondary, in: colorScheme)),
                    .isDefaultTextColor: true
                ]
                return NSAttributedString(string: "Notes...", attributes: attributes)
            }
        }()

        RichTextEditor(text: Binding<NSAttributedString>(
            get: {
                initialText
            },
            set: { newValue in
                let mutableAttributedString = NSMutableAttributedString(attributedString: newValue)
                let themeUIColor = UIColor(themeColor(from: theme, for: .secondary, in: colorScheme))

                mutableAttributedString.enumerateAttribute(.foregroundColor, in: NSRange(location: 0, length: mutableAttributedString.length), options: []) { value, range, _ in
                    if let color = value as? UIColor, color == themeUIColor {
                        mutableAttributedString.addAttribute(.isDefaultTextColor, value: true, range: range)
                    } else {
                        mutableAttributedString.addAttribute(.isDefaultTextColor, value: false, range: range)
                    }
                }

                guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: mutableAttributedString, requiringSecureCoding: false) else {
                    return
                }
                let base64String = encodedData.base64EncodedString()

                if let index = space.windows.firstIndex(where: { $0.id == windowId }) {
                    space.windows[index].data.saveData[key] = base64String
                }

                space.updateDateModified()
            }
        ))
        .padding(.top, 12)
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
