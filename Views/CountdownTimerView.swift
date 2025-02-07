import SwiftUI

struct CountdownTimerView: View {
    @Environment(\.theme) var theme
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    private var eventName: String {
        space.windows.first(where: { $0.id == windowId })?.data.saveData["eventName"] ?? ""
    }
    
    private var selectedDate: Date {
        if let dateString = space.windows.first(where: { $0.id == windowId })?.data.saveData["selectedDate"],
           let date = Self.isoFormatter.date(from: dateString)
        {
            return date
        }
        return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    }
    
    private var targetDate: Date? {
        if let dateString = space.windows.first(where: { $0.id == windowId })?.data.saveData["targetDate"],
           let date = Self.isoFormatter.date(from: dateString)
        {
            return date
        }
        return nil
    }
    
    private var eventNameBinding: Binding<String> {
        Binding<String>(
            get: { self.eventName },
            set: { newValue in
                if let index = self.space.windows.firstIndex(where: { $0.id == self.windowId }) {
                    self.space.windows[index].data.saveData["eventName"] = newValue
                }
            }
        )
    }
    
    private var selectedDateBinding: Binding<Date> {
        Binding<Date>(
            get: { self.selectedDate },
            set: { newValue in
                if let index = self.space.windows.firstIndex(where: { $0.id == self.windowId }) {
                    self.space.windows[index].data.saveData["selectedDate"] = Self.isoFormatter.string(from: newValue)
                }
            }
        )
    }
    
    private static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
    
    var body: some View {
        VStack {
            if targetDate == nil {
                VStack(spacing: 0) {
                    TextField("", text: eventNameBinding, prompt: Text("Event...")
                        .foregroundStyle(
                            themeColor(from: theme, for: .secondary, in: colorScheme, level: 1.4)
                                .opacity(0.67)
                        ))
                        .textFieldStyle(.plain)
                        .padding(.horizontal, 16)
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .medium))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 20)
                    
                    if colorScheme == .light {
                        DatePicker("Enter date", selection: selectedDateBinding, displayedComponents: .date)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .colorInvert()
                            .colorMultiply(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
                    } else {
                        DatePicker("Enter date", selection: selectedDateBinding, displayedComponents: .date)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .colorMultiply(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0))
                    }
                    
                    Spacer()
                    
                    Button(action: startCountdown) {
                        Text("Countdown!")
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .frame(maxWidth: 200)
                            .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 4.5))
                            .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1.2))
                            .cornerRadius(16)
                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                    }
                    .padding(.horizontal)
                    .disabled(!isValidDate)
                    .opacity(isValidDate ? 1 : 0.5)
                    .gesture(DragGesture().onChanged { _ in })
                }
                .safeAreaPadding(.vertical, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                CountdownDisplayView(eventName: eventName, targetDate: targetDate!)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.75))
    }
    
    var isValidDate: Bool {
        let oneHourLater = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        let maxDate = Calendar.current.date(byAdding: .day, value: 9990, to: Date())!
        return selectedDate >= oneHourLater && selectedDate <= maxDate
    }
    
    func startCountdown() {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        components.hour = 9
        components.minute = 0
        components.second = 0
        guard let target = calendar.date(from: components) else { return }
        
        if let index = space.windows.firstIndex(where: { $0.id == windowId }) {
            withAnimation(.snappy(duration: 0.4)) {
                space.windows[index].data.saveData["targetDate"] = Self.isoFormatter.string(from: target)
                space.windows[index].data.minWidth = 380
                space.windows[index].data.maxWidth = 420
                space.windows[index].data.minHeight = 230
                space.windows[index].data.maxHeight = 280
                space.windows[index].state.width = 396
                space.windows[index].state.height = 230
            }
        }
    }
}

struct CountdownDisplayView: View {
    var eventName: String
    var targetDate: Date
    
    @State var dummyTick: Bool = false
    
    var timeRemaining: TimeInterval {
        _ = dummyTick
        return max(targetDate.timeIntervalSince(Date()), 0)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text(eventName.isEmpty ? "Event" : eventName)
                .font(.system(size: 36, weight: .semibold))
                .padding(.horizontal, 16)
                .lineLimit(1)
            
            CountdownTimeView(timeRemaining: timeRemaining)
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            dummyTick.toggle()
        }
    }
}

struct CountdownTimeView: View {
    let timeRemaining: TimeInterval
    
    var body: some View {
        let (days, hours, minutes, seconds) = breakdown(time: timeRemaining)
        return HStack(spacing: 16) {
            VStack(spacing: 8) {
                Text("\(min(9999, days).description)")
                    .font(.system(size: 44, weight: .semibold, design: .monospaced))
                    .lineLimit(1)
                Text("DAY\(days == 1 ? "" : "S")")
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
            }
            .frame(minWidth: 68)
            VStack(spacing: 8) {
                Text("\(hours.description)")
                    .font(.system(size: 44, weight: .semibold, design: .monospaced))
                    .lineLimit(1)
                Text("HOUR\(hours == 1 ? "" : "S")")
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
            }
            .frame(minWidth: 68)
            VStack(spacing: 8) {
                Text("\(minutes.description)")
                    .font(.system(size: 44, weight: .semibold, design: .monospaced))
                    .lineLimit(1)
                Text("MIN")
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
            }
            .frame(minWidth: 68)
            VStack(spacing: 8) {
                Text("\(seconds.description)")
                    .font(.system(size: 44, weight: .semibold, design: .monospaced))
                    .lineLimit(1)
                Text("SEC")
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
            }
            .frame(minWidth: 68)
        }
    }
    
    func breakdown(time: TimeInterval) -> (Int, Int, Int, Int) {
        let totalSeconds = max(Int(time), 0)
        let days = totalSeconds / (24 * 3600)
        let hours = (totalSeconds % (24 * 3600)) / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = (totalSeconds % 60)
        return (days, hours, minutes, seconds)
    }
}

struct CountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerView()
    }
}
