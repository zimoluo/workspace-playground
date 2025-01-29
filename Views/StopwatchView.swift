import SwiftUI

enum StopwatchState: String, Codable {
    case initial
    case running
    case paused
}

struct StopwatchView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    @State private var dummyTick = false

    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    private var window: Window? {
        space.windows.first { $0.id == windowId }
    }

    private var currentState: (StopwatchState, Date?, TimeInterval, [TimeInterval]) {
        guard let data = window?.data.saveData["stopwatchState"],
              let decodedData = try? JSONDecoder().decode(StopwatchStorage.self, from: Data(data.utf8))
        else {
            return (.initial, nil, 0, [])
        }
        return (decodedData.state, decodedData.startDate, decodedData.accumulatedTime, decodedData.laps)
    }

    private var stopwatchState: StopwatchState {
        currentState.0
    }

    private var startDate: Date? {
        currentState.1
    }

    private var accumulatedTime: TimeInterval {
        currentState.2
    }

    private var laps: [TimeInterval] {
        currentState.3
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Spacer()
                    Text(formatTime(currentElapsedTime))
                        .font(.system(size: geometry.size.width * 0.126, weight: .bold, design: .monospaced))
                        .foregroundColor(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                        .fixedSize()
                        .frame(height: geometry.size.width * 0.13)
                        .frame(maxWidth: .infinity)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Spacer()
                    buttonsView
                }
                .frame(height: (geometry.size.width * 0.5).clamped(to: 100 ... 180))
                .frame(maxWidth: .infinity)
                .padding(.bottom, 12)

                RoundedRectangle(cornerRadius: 1)
                    .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1).opacity(0.5))
                    .frame(width: geometry.size.width * 0.9, height: 2)

                ScrollView {
                    VStack(spacing: 8) {
                        if stopwatchState != .initial {
                            HStack {
                                Text("Lap \(laps.count + 1)")
                                Spacer()
                                Text(formatTime(currentElapsedTime - laps.reduce(0, +)))
                            }
                            .padding(.horizontal)
                            .font(.system(.headline, design: .monospaced))
                            .foregroundColor(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                        }

                        ForEach(Array(zip(laps.indices, laps)).reversed(), id: \.0) { index, timeInterval in
                            HStack {
                                Text("Lap \(index + 1)")
                                Spacer()
                                Text(formatTime(timeInterval))
                            }
                            .padding(.horizontal)
                            .font(.system(.headline, design: .monospaced))
                            .foregroundColor(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                        }
                    }
                    .padding(.vertical, 16)
                }
                .frame(maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onReceive(timer) { _ in
            if stopwatchState == .running {
                dummyTick.toggle()
            }
        }
    }

    @ViewBuilder
    private var buttonsView: some View {
        HStack(spacing: stopwatchState == .initial ? 0 : 12) {
            Button(action: {
                if stopwatchState == .running {
                    saveState(state: .running, startDate: startDate, accumulatedTime: accumulatedTime, laps: laps + [currentElapsedTime - laps.reduce(0, +)])
                } else if stopwatchState == .paused {
                    saveState(state: .initial, startDate: nil, accumulatedTime: 0, laps: [])
                }
            }) {
                Text(stopwatchState == .running ? "Lap" : "Reset")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(9)
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
                    .foregroundColor(themeColor(from: theme, for: stopwatchState == .running ? .secondary : .tertiary, in: colorScheme, level: 5))
                    .background(themeColor(from: theme, for: stopwatchState == .running ? .secondary : .tertiary, in: colorScheme, level: 2))
                    .cornerRadius(16)
                    .shadow(color: (stopwatchState == .running ? theme.secondary : theme.tertiary).toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
            }
            .frame(maxWidth: stopwatchState == .initial ? 0 : .infinity)
            .opacity(stopwatchState == .initial ? 0 : 1)
            .animation(.spring(duration: 0.3), value: stopwatchState)
            .gesture(DragGesture().onChanged { _ in })

            Button(action: {
                switch stopwatchState {
                case .initial:
                    saveState(state: .running, startDate: Date(), accumulatedTime: 0, laps: [])
                case .running:
                    saveState(state: .paused, startDate: nil, accumulatedTime: currentElapsedTime, laps: laps)
                case .paused:
                    saveState(state: .running, startDate: Date(), accumulatedTime: accumulatedTime, laps: laps)
                }
            }) {
                Text(mainButtonTitle)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(9)
                    .frame(maxWidth: stopwatchState == .initial ? 210 : .infinity)
                    .lineLimit(1)
                    .foregroundColor(mainButtonForegroundColor)
                    .background(mainButtonBackgroundColor)
                    .cornerRadius(16)
                    .shadow(color: mainButtonShadowColor, radius: 12, y: 8)
            }
            .animation(.spring(duration: 0.3), value: stopwatchState)
            .gesture(DragGesture().onChanged { _ in })
        }
        .animation(.spring(duration: 0.3), value: stopwatchState)
        .padding(.horizontal, 12)
    }

    private var mainButtonTitle: String {
        switch stopwatchState {
        case .initial: return "Start"
        case .running: return "Stop"
        case .paused: return "Resume"
        }
    }

    private var mainButtonForegroundColor: Color {
        switch stopwatchState {
        case .initial, .paused:
            return themeColor(from: theme, for: .secondary, in: colorScheme, level: 5)
        case .running:
            return themeColor(from: theme, for: .tertiary, in: colorScheme, level: 5)
        }
    }

    private var mainButtonBackgroundColor: Color {
        switch stopwatchState {
        case .initial, .paused:
            return themeColor(from: theme, for: .secondary, in: colorScheme, level: 1)
        case .running:
            return themeColor(from: theme, for: .tertiary, in: colorScheme, level: 1)
        }
    }

    private var mainButtonShadowColor: Color {
        (stopwatchState == .running ? theme.tertiary : theme.secondary).toShadow(opacityMultiplier: 0.8)
    }

    private var currentElapsedTime: TimeInterval {
        _ = dummyTick
        guard stopwatchState == .running, let startDate else {
            return accumulatedTime
        }
        return accumulatedTime + Date().timeIntervalSince(startDate)
    }

    private func saveState(state: StopwatchState, startDate: Date?, accumulatedTime: TimeInterval, laps: [TimeInterval]) {
        let storage = StopwatchStorage(state: state, startDate: startDate, accumulatedTime: accumulatedTime, laps: laps)
        if let encoded = try? JSONEncoder().encode(storage),
           let jsonString = String(data: encoded, encoding: .utf8)
        {
            if let index = space.windows.firstIndex(where: { $0.id == windowId }) {
                space.windows[index].data.saveData["stopwatchState"] = jsonString
            }
        }
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let clampedTime = max(0, time)
        let totalHundredths = min(Int((clampedTime * 100).rounded()), (999 * 360000) + (59 * 6000) + (59 * 100) + 99)
        let hours = totalHundredths / 360000
        let minutes = (totalHundredths / 6000) % 60
        let seconds = (totalHundredths / 100) % 60
        let hundredths = totalHundredths % 100

        if hours > 0 {
            return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, hundredths)
        } else {
            return String(format: "%02d:%02d.%02d", minutes, seconds, hundredths)
        }
    }
}

struct StopwatchStorage: Codable {
    let state: StopwatchState
    let startDate: Date?
    let accumulatedTime: TimeInterval
    let laps: [TimeInterval]
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}
