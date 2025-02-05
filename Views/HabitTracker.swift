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

                Spacer()

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
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(settings.habits, id: \.id) { item in
                        HabitRow(habitId: item.id)
                            .focused($focusedItemID, equals: item.id)
                            .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
                .safeAreaPadding(.bottom, 12)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func addItem() {
        let newItem = Habit(id: UUID(), name: "", dateCreated: Date(), dateModified: Date(), timesKept: [], timesDisliked: [])
        settings.habits.insert(newItem, at: 0)
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

    @State private var isLiked = false
    @State private var isDisliked = false

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

    private var sinceDate: Date {
        if let index = settings.habits.firstIndex(where: { $0.id == habitId }) {
            return settings.habits[index].dateCreated
        }

        return Date()
    }

    private var score: Int {
        if let index = settings.habits.firstIndex(where: { $0.id == habitId }) {
            return max(0, settings.habits[index].timesKept.count - settings.habits[index].timesDisliked.count)
        }

        return 0
    }

    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
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
                .font(.system(size: 19, weight: .semibold))

                Text("Since \(formattedDateString(for: sinceDate))")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(
                        themeColor(from: theme, for: .secondary, in: colorScheme, level: 2)
                            .opacity(0.75)
                    )
                    .lineLimit(1)
            }
            Spacer()

            if score > 0 {
                Text("\(score)")
                    .font(.system(size: 20, weight: .medium, design: .monospaced))
                    .transition(.scale.combined(with: .opacity))
                    .id(score)
                    .padding(4)
            }

            Button(action: {
                withAnimation(.snappy) {
                    if let index = settings.habits.firstIndex(where: { $0.id == habitId }) {
                        settings.habits[index].timesKept.append(Date())
                        isLiked.toggle()
                    }
                }
            }) {
                Image(systemName: "heart")
                    .font(.system(size: 20, weight: .medium))
                    .padding(4)
                    .symbolEffect(.bounce, value: isLiked)
            }
            .gesture(DragGesture().onChanged { _ in })
            Button(action: {
                withAnimation(.snappy) {
                    if let index = settings.habits.firstIndex(where: { $0.id == habitId }) {
                        settings.habits[index].timesDisliked.append(Date())
                        isDisliked.toggle()
                    }
                }
            }) {
                Image(systemName: "hand.thumbsdown")
                    .font(.system(size: 20, weight: .medium))
                    .padding(4)
                    .symbolEffect(.bounce, value: isDisliked)
            }
            .gesture(DragGesture().onChanged { _ in })
            Button(action: {
                withAnimation(.snappy) {
                    if let index = settings.habits.firstIndex(where: { $0.id == habitId }) {
                        settings.habits.remove(at: index)
                    }
                }
            }) {
                Image(systemName: "trash")
                    .font(.system(size: 20, weight: .medium))
                    .padding(4)
            }
            .gesture(DragGesture().onChanged { _ in })
        }
        .padding(.vertical, 4)
        .background(Color.clear)
    }
}
