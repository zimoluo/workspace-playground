import SwiftUI

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
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.75))

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
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.75))
            }
            .padding(.top, 8)
            .padding(8)

            ScrollView {
                LazyVStack {
                    ForEach(itemsBinding.wrappedValue, id: \.id) { item in
                        TodoItemRow(
                            item: item,
                            items: itemsBinding,
                            onDelete: {
                                withAnimation(.snappy) {
                                    deleteItem(withId: item.id)
                                }
                            }
                        )
                        .focused($focusedItemID, equals: item.id)
                        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                    }
                }
                .padding(.horizontal, 16)
                .safeAreaPadding(.bottom, 12)
                .frame(maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func addItem() {
        let newItem = TodoItem(title: "")
        var currentItems = itemsBinding.wrappedValue
        currentItems.insert(newItem, at: 0)
        itemsBinding.wrappedValue = currentItems

        focusedItemID = newItem.id
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
}

struct TodoItemRow: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var item: TodoItem
    @Binding var items: [TodoItem]
    var onDelete: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            TextField(
                "",
                text: Binding(
                    get: { item.title },
                    set: { newValue in
                        if let index = items.firstIndex(where: { $0.id == item.id }) {
                            items[index].title = newValue
                        }
                    }
                ),
                prompt: Text("Item...")
                    .foregroundStyle(
                        themeColor(from: theme, for: .secondary, in: colorScheme, level: 2)
                            .opacity(0.67)
                    )
            )
            .textFieldStyle(.plain)
            .font(.system(size: 17, weight: .medium))

            Button(action: {
                withAnimation(.snappy) {
                    onDelete()
                }
            }) {
                Image(systemName: "circle.circle")
                    .padding(4)
                    .font(.system(size: 18, weight: .medium))
            }
            .accessibilityLabel("Complete Item")
            .gesture(DragGesture().onChanged { _ in })
        }
        .padding(.vertical, 4)
    }
}
