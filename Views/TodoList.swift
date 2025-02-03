import SwiftUI

extension Binding {
    subscript<Element>(index: Int) -> Binding<Element> where Value == [Element] {
        Binding<Element>(
            get: { self.wrappedValue[index] },
            set: { newValue in
                var copy = self.wrappedValue
                copy[index] = newValue
                self.wrappedValue = copy
            }
        )
    }
}

struct TodoItem: Identifiable, Equatable, Codable {
    let id: UUID
    var title: String

    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}

struct TodoListView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    @FocusState private var focusedItemID: UUID?

    private var listTitleBinding: Binding<String> {
        Binding<String>(
            get: {
                if let window = space.windows.first(where: { $0.id == windowId }) {
                    return window.data.saveData["listTitle"] ?? "To-do"
                }
                return "To-do"
            },
            set: { newTitle in
                if let index = space.windows.firstIndex(where: { $0.id == windowId }) {
                    space.windows[index].data.saveData["listTitle"] = newTitle
                }
            }
        )
    }

    private var itemsBinding: Binding<[TodoItem]> {
        Binding<[TodoItem]>(
            get: {
                if let window = space.windows.first(where: { $0.id == windowId }) {
                    let json = window.data.saveData["items"] ?? "[]"
                    if let data = json.data(using: .utf8),
                       let decoded = try? JSONDecoder().decode([TodoItem].self, from: data)
                    {
                        return decoded
                    }
                }
                return []
            },
            set: { newItems in
                if let data = try? JSONEncoder().encode(newItems),
                   let json = String(data: data, encoding: .utf8),
                   let index = space.windows.firstIndex(where: { $0.id == windowId })
                {
                    space.windows[index].data.saveData["items"] = json
                }
            }
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField(
                    "",
                    text: listTitleBinding,
                    prompt: Text("Title...")
                        .foregroundStyle(
                            themeColor(from: theme, for: .secondary, in: colorScheme, level: 2)
                                .opacity(0.67)
                        )
                )
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
                ForEach(itemsBinding.wrappedValue, id: \.id) { item in
                    if let binding = itemsBinding.binding(for: item.id) {
                        TodoItemRow(item: binding) {
                            withAnimation(.snappy) {
                                deleteItem(withId: item.id)
                            }
                        }
                        .focused($focusedItemID, equals: item.id)
                        .listRowBackground(themeColor(from: theme, for: .secondary, in: colorScheme, level: 4))
                        .listRowSeparator(.hidden)
                        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                    }
                }
                .onMove(perform: moveItems)
            }
            .listStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func addItem() {
        let newItem = TodoItem(title: "")
        var currentItems = itemsBinding.wrappedValue
        currentItems.insert(newItem, at: 0)
        itemsBinding.wrappedValue = currentItems

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            focusedItemID = newItem.id
        }
    }

    private func deleteItem(withId id: UUID) {
        var currentItems = itemsBinding.wrappedValue

        guard let index = currentItems.firstIndex(where: { $0.id == id }) else {
            return
        }

        if index < currentItems.count {
            currentItems.remove(at: index)
            itemsBinding.wrappedValue = currentItems
        }
    }

    private func moveItems(from source: IndexSet, to destination: Int) {
        var currentItems = itemsBinding.wrappedValue
        currentItems.move(fromOffsets: source, toOffset: destination)
        itemsBinding.wrappedValue = currentItems
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
        HStack(spacing: 10) {
            TextField(
                "",
                text: $item.title,
                prompt: Text("Item...")
                    .foregroundStyle(
                        themeColor(from: theme, for: .secondary, in: colorScheme, level: 2)
                            .opacity(0.67)
                    )
            )
            .textFieldStyle(.plain)
            .font(.system(size: 17, weight: .medium))

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
            .contentShape(Rectangle())
            .accessibilityLabel("Complete Item")
            .frame(width: 30, height: 30)
            .gesture(DragGesture().onChanged { _ in })
        }
        .padding(.vertical, 4)
        .background(Color.clear)
        .contentShape(Rectangle())
        .onTapGesture {
            if isActive {
                withAnimation(.snappy) {
                    cancelDeletion()
                }
            } else {
                withAnimation(.snappy) {
                    startDeletionCountdown()
                }
            }
        }
    }

    private func startDeletionCountdown() {
        isActive = true
        progress = 0.0
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if progress >= 1.0 {
                timer.invalidate()
                withAnimation(.snappy) {
                    onDelete()
                }
                isActive = false
                progress = 0.0
            } else {
                withAnimation(.linear(duration: 0.1)) {
                    progress += 0.201
                }
            }
        }
    }

    private func cancelDeletion() {
        timer?.invalidate()
        timer = nil
        withAnimation(.none) {
            progress = 0.0
        }
        isActive = false
    }
}

extension Binding where Value: MutableCollection, Value.Element: Identifiable {
    func binding(for id: Value.Element.ID) -> Binding<Value.Element>? {
        guard let index = wrappedValue.firstIndex(where: { $0.id == id }) else { return nil }
        return self[index]
    }
}
