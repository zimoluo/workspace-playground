import SwiftUI

struct TodoItem: Identifiable, Equatable {
    let id = UUID()
    var title: String
}

struct TodoListView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @State private var listTitle: String = "To-do"
    @State private var items: [TodoItem] = []
    @FocusState private var focusedItemID: UUID?

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("", text: $listTitle, prompt: Text("Title...")
                    .foregroundStyle(
                        themeColor(from: theme, for: .secondary, in: colorScheme, level: 2)
                            .opacity(0.67)
                    ))
                    .textFieldStyle(.plain)
                    .padding(.leading, 8)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))

                Button {
                    withAnimation(.snappy) {
                        addItem()
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .padding(8)
                }
                .accessibilityLabel("Add Item")
                .gesture(DragGesture().onChanged { _ in })
            }
            .padding(.top, 8)
            .padding(8)

            List {
                ForEach($items) { $item in
                    TodoItemRow(item: $item) {
                        if let index = items.firstIndex(where: { $0.id == item.id }) {
                            items.remove(at: index)
                        }
                    }
                    .focused($focusedItemID, equals: item.id)
                    .listRowBackground(themeColor(from: theme, for: .secondary, in: colorScheme, level: 4))
                    .listRowSeparator(.hidden)
                    .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                }
                .onMove(perform: moveItems)
            }
            .listStyle(PlainListStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func addItem() {
        let newItem = TodoItem(title: "")
        items.insert(newItem, at: 0)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            focusedItemID = newItem.id
        }
    }

    private func moveItems(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
}

struct TodoItemRow: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @Binding var item: TodoItem
    var onDelete: () -> Void

    @State private var isActive: Bool = false
    @State private var progress: Double = 0.0
    @State private var timer: Timer?

    var body: some View {
        HStack(spacing: 6) {
            TextField("", text: $item.title, prompt: Text("Item...")
                .foregroundStyle(
                    themeColor(from: theme, for: .secondary, in: colorScheme, level: 2)
                        .opacity(0.67)
                ))
                .textFieldStyle(.plain)
                .font(.system(size: 17, weight: .medium))

            Button(action: {
                if isActive {
                    withAnimation(.snappy) {
                        cancelDeletion()
                    }
                } else {
                    withAnimation(.snappy) {
                        startDeletionCountdown()
                    }
                }
            }) {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 2.7)
                        .frame(width: 19, height: 19)
                        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2))

                    if isActive {
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                themeColor(from: theme, for: .secondary, in: colorScheme, level: 2),
                                style: StrokeStyle(lineWidth: 2.7, lineCap: .round)
                            )
                            .frame(width: 9, height: 9)
                            .rotationEffect(.degrees(-90))
                    }
                }
                .frame(width: 30, height: 30)
                .contentShape(Circle())
            }
            .accessibilityLabel("Complete Item")
        }
        .padding(.vertical, 4)
    }

    private func startDeletionCountdown() {
        isActive = true
        progress = 0.0
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if progress >= 1.0 {
                timer.invalidate()
                withAnimation(.snappy) {
                    onDelete()
                }
                isActive = false
                progress = 0.0
            } else {
                withAnimation(.linear(duration: 0.3)) {
                    progress += 0.1 // 0.3 / 3.0
                }
            }
        }
    }

    // Cancels deletion and resets progress
    private func cancelDeletion() {
        timer?.invalidate()
        timer = nil
        withAnimation(.none) {
            progress = 0.0
        }
        isActive = false
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
