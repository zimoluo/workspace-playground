import SwiftUI

struct ImportantDatesView: View {
    @Environment(\.settings) private var settings
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    enum ViewState: Codable {
        case add
        case list
        case display(ImportantDay)
    }

    private static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    private var viewStateBinding: Binding<ViewState> {
        Binding<ViewState>(
            get: {
                if let window = space.windows.first(where: { $0.id == windowId }),
                   let jsonString = window.data.saveData["viewState"],
                   let data = jsonString.data(using: .utf8),
                   let state = try? JSONDecoder().decode(ViewState.self, from: data)
                {
                    return state
                }
                return .list
            },
            set: { newState in
                if let index = space.windows.firstIndex(where: { $0.id == windowId }),
                   let data = try? JSONEncoder().encode(newState),
                   let jsonString = String(data: data, encoding: .utf8)
                {
                    space.windows[index].data.saveData["viewState"] = jsonString
                }
            }
        )
    }

    private var newDayNameBinding: Binding<String> {
        Binding<String>(
            get: {
                space.windows.first(where: { $0.id == windowId })?.data.saveData["newDayName"] ?? ""
            },
            set: { newValue in
                if let index = space.windows.firstIndex(where: { $0.id == windowId }) {
                    space.windows[index].data.saveData["newDayName"] = newValue
                }
            }
        )
    }

    private var newDayDateBinding: Binding<Date> {
        Binding<Date>(
            get: {
                if let dateString = space.windows.first(where: { $0.id == windowId })?.data.saveData["newDayDate"],
                   let date = Self.isoFormatter.date(from: dateString)
                {
                    return date
                }
                return Date()
            },
            set: { newValue in
                if let index = space.windows.firstIndex(where: { $0.id == windowId }) {
                    space.windows[index].data.saveData["newDayDate"] = Self.isoFormatter.string(from: newValue)
                }
            }
        )
    }

    private var viewState: ViewState {
        viewStateBinding.wrappedValue
    }

    private var newDayName: String {
        newDayNameBinding.wrappedValue
    }

    private var newDayDate: Date {
        newDayDateBinding.wrappedValue
    }

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
                            newDayNameBinding.wrappedValue = ""
                            newDayDateBinding.wrappedValue = Date()
                            viewStateBinding.wrappedValue = .add
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .bold))
                    }
                    .gesture(DragGesture().onChanged { _ in })
                } else if shouldShowBackButton {
                    Button(action: {
                        withAnimation(.snappy(duration: 0.4)) {
                            viewStateBinding.wrappedValue = .list
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
            TextField("", text: newDayNameBinding, prompt: Text("Milestone...")
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
                DatePicker("Enter date", selection: newDayDateBinding, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .colorInvert()
                    .colorMultiply(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
            } else {
                DatePicker("Enter date", selection: newDayDateBinding, displayedComponents: .date)
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
            .gesture(DragGesture().onChanged { _ in })
        }
        .safeAreaPadding(.bottom, 20)
    }

    private func saveNewImportantDay() {
        let newDay = ImportantDay(id: UUID(), name: newDayName.isEmpty ? "Milestone" : newDayName, date: newDayDate)
        settings.importantDays.append(newDay)
        viewStateBinding.wrappedValue = .list
    }

    private var listView: some View {
        ScrollView {
            LazyVStack(spacing: 18) {
                ForEach(settings.importantDays.sorted { $0.date > $1.date }) { day in
                    Button(action: {
                        withAnimation(.snappy(duration: 0.4)) {
                            viewStateBinding.wrappedValue = .display(day)
                        }
                    }) {
                        HStack(spacing: 16) {
                            Text(day.name)
                                .font(.system(size: 16, weight: .semibold))
                                .lineLimit(1)
                            Spacer()
                            Text(daysDisplay(for: day, true))
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
            .animation(.spring(duration: 0.4), value: settings.importantDays)
            .safeAreaPadding(.vertical, 12)
            .safeAreaPadding(.horizontal, 20)
        }
    }

    private func daysDisplay(for day: ImportantDay, _ isList: Bool = false) -> String {
        let calendar = Calendar.current
        let now = calendar.startOfDay(for: Date())
        let target = calendar.startOfDay(for: day.date)
        let diff = calendar.dateComponents([.day], from: now, to: target).day ?? 0
        if diff > 0 {
            return "\(isList ? "In " : "")\(diff) days\(isList ? "" : " until")"
        } else if diff < 0 {
            return "\(-diff) days \(isList ? "ago" : "since")"
        } else {
            return "Today"
        }
    }

    private func displayView(for day: ImportantDay) -> some View {
        VStack(spacing: 14) {
            Text(daysDisplay(for: day).uppercased())
                .font(.system(size: 24, weight: .semibold))
                .lineLimit(1)
            Text(day.name)
                .font(.system(size: 48, weight: .bold))
                .lineLimit(2)
        }
        .onTapGesture {
            withAnimation(.snappy(duration: 0.4)) {
                viewStateBinding.wrappedValue = .list
            }
        }
        .padding(16)
        .frame(maxHeight: .infinity)
        .padding(.bottom, 48)
        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.8))
    }
}
