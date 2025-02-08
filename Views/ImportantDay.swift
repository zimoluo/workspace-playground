import SwiftUI

struct ImportantDatesView: View {
    @Environment(\.settings) private var settings
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    enum ViewState: Codable {
        case add
        case list
        case display(ImportantDay)
    }

    @State private var viewState: ViewState = .add

    @State private var newDayName: String = ""
    @State private var newDayDate: Date = .init()

    var body: some View {
        VStack(spacing: 0) {
            headerView
            contentView
        }
    }

    private var headerView: some View {
        ZStack {
            Text(headerTitle)
                .font(.system(size: 18, weight: .bold))
                .contentTransition(.numericText(countsDown: true))
            HStack {
                Spacer()
                if case .list = viewState {
                    Button(action: {
                        withAnimation(.snappy(duration: 0.4)) {
                            newDayName = ""
                            newDayDate = Date()
                            viewState = .add
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .bold))
                    }
                    .gesture(DragGesture().onChanged { _ in })
                } else if shouldShowBackButton {
                    Button(action: {
                        withAnimation(.snappy(duration: 0.4)) {
                            viewState = .list
                        }
                    }) {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 18, weight: .bold))
                    }
                    .gesture(DragGesture().onChanged { _ in })
                }
            }
            .padding(.horizontal, 8)
        }
        .padding(16)
        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.75))
    }

    private var headerTitle: String {
        switch viewState {
        case .add:
            return "New"
        case .list:
            return "Milestones"
        case .display:
            return "Milestone"
        }
    }

    private var shouldShowBackButton: Bool {
        switch viewState {
        case .display:
            return true
        case .add:
            return !settings.importantDays.isEmpty
        default:
            return false
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewState {
        case .add:
            addView
        case .list:
            listView
        case .display(let day):
            displayView(for: day)
        }
    }

    private var addView: some View {
        VStack(spacing: 0) {
            TextField("", text: $newDayName, prompt: Text("Milestone...")
                .foregroundStyle(
                    themeColor(from: theme, for: .secondary, in: colorScheme, level: 1.4)
                        .opacity(0.67)
                ))
                .textFieldStyle(.plain)
                .padding(.horizontal, 16)
                .lineLimit(1)
                .font(.system(size: 24, weight: .medium))
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.75))
            if colorScheme == .light {
                DatePicker("Enter date", selection: $newDayDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .colorInvert()
                    .colorMultiply(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
            } else {
                DatePicker("Enter date", selection: $newDayDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .colorMultiply(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
            }
            Spacer()
            Button(action: {
                withAnimation(.snappy(duration: 0.4)) {
                    saveNewImportantDay()
                }
            }) {
                Text("Add Milestone!")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(maxWidth: 200)
                    .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 4.5))
                    .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1.2))
                    .cornerRadius(16)
                    .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
            }
            .disabled(newDayName.isEmpty)
            .gesture(DragGesture().onChanged { _ in })
            .opacity(newDayName.isEmpty ? 0.5 : 1)
        }
        .safeAreaPadding(.bottom, 20)
    }

    private func saveNewImportantDay() {
        let newDay = ImportantDay(id: UUID(), name: newDayName, date: newDayDate)
        settings.importantDays.append(newDay)
        viewState = .list
    }

    private var listView: some View {
        ScrollView {
            LazyVStack(spacing: 18) {
                ForEach(settings.importantDays) { day in
                    Button(action: {
                        withAnimation(.snappy(duration: 0.4)) {
                            viewState = .display(day)
                        }
                    }) {
                        HStack(spacing: 16) {
                            Text(day.name)
                                .font(.system(size: 16, weight: .semibold))
                                .lineLimit(1)
                            Spacer()
                            Text(daysDisplay(for: day))
                                .font(.system(size: 14, weight: .semibold))
                                .lineLimit(1)
                        }
                        .padding(16)
                        .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 3.8))
                        .cornerRadius(16)
                        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1.15))
                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.4), radius: 8, y: 6)
                    }
                    .buttonStyle(.plain)
                    .gesture(DragGesture().onChanged { _ in })
                    .scrollTransition { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1 : 0.33)
                            .scaleEffect(phase.isIdentity ? 1 : 0.94)
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            withAnimation(.snappy(duration: 0.4)) {
                                if let index = settings.importantDays.firstIndex(where: { $0.id == day.id }) {
                                    settings.importantDays.remove(at: index)
                                }
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .animation(.spring(duration: 0.5), value: settings.importantDays)
            .safeAreaPadding(.vertical, 12)
            .safeAreaPadding(.horizontal, 20)
        }
    }

    private func daysDisplay(for day: ImportantDay) -> String {
        let calendar = Calendar.current
        let now = calendar.startOfDay(for: Date())
        let target = calendar.startOfDay(for: day.date)
        let diff = calendar.dateComponents([.day], from: now, to: target).day ?? 0
        if diff > 0 {
            return "\(diff) days until"
        } else if diff < 0 {
            return "\(-diff) days since"
        } else {
            return "Today"
        }
    }

    private func displayView(for day: ImportantDay) -> some View {
        VStack(spacing: 20) {
            Text(daysDisplay(for: day))
                .font(.system(size: 34, weight: .semibold))
                .lineLimit(1)
            Text(day.name)
                .font(.system(size: 44, weight: .bold))
                .lineLimit(2)
        }
        .padding(16)
        .frame(maxHeight: .infinity)
        .padding(.bottom, 32)
        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.8))
    }
}
