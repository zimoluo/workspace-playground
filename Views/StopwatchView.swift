import SwiftUI

enum StopwatchState: String, Codable {
    case initial
    case running
    case paused
}

struct StopwatchView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @State private var stopwatchState: StopwatchState = .initial
    @State private var startDate: Date? = nil
    @State private var accumulatedTime: TimeInterval = 0
    @State private var laps: [TimeInterval] = []
    @State private var dummyTick = false

    private let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()

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
                        // Display the active lap dynamically
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

                        // Display the recorded laps
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
                    lap()
                } else if stopwatchState == .paused {
                    resetStopwatch()
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

            Button(action: {
                switch stopwatchState {
                case .initial: startStopwatch()
                case .running: stopStopwatch()
                case .paused: resumeStopwatch()
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

    private func startStopwatch() {
        startDate = Date()
        accumulatedTime = 0
        laps = []
        stopwatchState = .running
    }

    private func stopStopwatch() {
        if let startDate {
            accumulatedTime += Date().timeIntervalSince(startDate)
        }
        startDate = nil
        stopwatchState = .paused
    }

    private func resumeStopwatch() {
        startDate = Date()
        stopwatchState = .running
    }

    private func resetStopwatch() {
        startDate = nil
        accumulatedTime = 0
        laps.removeAll()
        stopwatchState = .initial
    }

    private func lap() {
        let lapTime = currentElapsedTime - laps.reduce(0, +)
        laps.append(lapTime)
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let clampedTime = max(0, time)
        let totalMilliseconds = min(Int((clampedTime * 1000).rounded()), (99 * 3600000) + (59 * 60000) + (59 * 1000) + 999)
        let hours = totalMilliseconds / 3600000
        let minutes = (totalMilliseconds / 60000) % 60
        let seconds = (totalMilliseconds / 1000) % 60
        let milliseconds = totalMilliseconds % 1000

        if hours > 0 {
            return String(format: "%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds)
        } else {
            return String(format: "%02d:%02d.%03d", minutes, seconds, milliseconds)
        }
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}
