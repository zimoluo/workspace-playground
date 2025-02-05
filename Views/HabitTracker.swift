import SwiftUI

struct HabitTrackerView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.settings) private var settings

    @FocusState private var focusedItemID: UUID?

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Habits")
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
            LazyVStack {
                ForEach(settings.habits, id: \.id) { item in
                    HabitRow(habitId: item.id)
                        .focused($focusedItemID, equals: item.id)
                        .listRowBackground(themeColor(from: theme, for: .secondary, in: colorScheme, level: 4))
                        .listRowSeparator(.hidden)
                        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func addItem() {
        let newItem = Habit(id: UUID(), name: "", dateCreated: Date(), dateModified: Date(), timesKept: [], timesDisliked: [])
        settings.habits.append(newItem)
        focusedItemID = newItem.id
    }

    private func deleteItem(withId id: UUID) {
        guard let index = settings.habits.firstIndex(where: { $0.id == id }) else {
            return
        }
        if index < settings.habits.count {
            settings.habits.remove(at: index)
        }
    }
}

struct HabitRow: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.settings) private var settings

    var habitId: UUID

    private var nameBinding: Binding<String> {
        if let index = settings.habits.firstIndex(where: { $0.id == habitId }) {
            return Binding(
                get: { settings.habits[index].name },
                set: { newValue in
                    settings.habits[index].name = newValue
                    settings.habits[index].dateModified = Date()
                }
            )
        }
        return .constant("")
    }

    var body: some View {
        HStack(spacing: 10) {
            TextField(
                "",
                text: nameBinding,
                prompt: Text("Habit...")
                    .foregroundStyle(
                        themeColor(from: theme, for: .secondary, in: colorScheme, level: 2)
                            .opacity(0.67)
                    )
            )
            .textFieldStyle(.plain)
            .font(.system(size: 17, weight: .medium))
            Spacer()
            Button(action: {}) {
                Image(systemName: "heart")
                    .font(.system(size: 19, weight: .medium))
            }
            .gesture(DragGesture().onChanged { _ in })
            Button(action: {}) {
                Image(systemName: "heart")
                    .font(.system(size: 19, weight: .medium))
            }
            .gesture(DragGesture().onChanged { _ in })
            Button(action: {}) {
                Image(systemName: "heart")
                    .font(.system(size: 19, weight: .medium))
            }
            .gesture(DragGesture().onChanged { _ in })
        }
        .padding(.vertical, 4)
        .background(Color.clear)
    }
}
