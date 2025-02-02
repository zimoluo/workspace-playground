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
        let newItem = TodoItem(title: "New Item")
        items.append(newItem)

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

    var body: some View {
        TextField("", text: $item.title, prompt: Text("Item...")
            .foregroundStyle(
                themeColor(from: theme, for: .secondary, in: colorScheme, level: 2)
                    .opacity(0.67)
            ))
            .textFieldStyle(.plain)
            .font(.system(size: 17, weight: .medium))
            .padding(.vertical, 3.5)
            .swipeActions {
                Button(role: .destructive, action: onDelete) {
                    Label("Delete", systemImage: "trash")
                }
            }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
