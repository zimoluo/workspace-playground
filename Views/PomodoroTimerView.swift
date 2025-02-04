import Combine
import SwiftUI

enum PomodoroTimerStatus: String, Codable {
    case initial
    case running
    case paused
}

struct PomodoroTimerStorage: Codable {
    let state: PomodoroTimerStatus
    let startDate: Date?
    let accumulatedTime: TimeInterval
}

struct PomodoroTimerView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var dummyTick = false

    private var currentState: PomodoroTimerStorage {
        guard
            let dataString = window?.data.saveData["pomodoroState"],
            let decoded = try? JSONDecoder().decode(PomodoroTimerStorage.self, from: Data(dataString.utf8))
        else {
            return PomodoroTimerStorage(state: .initial, startDate: nil, accumulatedTime: 0)
        }
        return decoded
    }

    private var pomodoroState: PomodoroTimerStatus { currentState.state }
    private var startDate: Date? { currentState.startDate }
    private var accumulatedTime: TimeInterval { currentState.accumulatedTime }

    private var window: Window? {
        space.windows.first(where: { $0.id == windowId })
    }

    private var totalElapsedTime: TimeInterval {
        if pomodoroState == .running, let start = startDate {
            return accumulatedTime + Date().timeIntervalSince(start)
        } else {
            return accumulatedTime
        }
    }

    private enum PomSegmentType: String {
        case pomodoro = "Pomodoro"
        case shortBreak = "Short Break"
        case longBreak = "Long Break"
    }

    private let pomodoroCycle: [(PomSegmentType, TimeInterval)] = [
        (.pomodoro, 25 * 60),
        (.shortBreak, 5 * 60),
        (.pomodoro, 25 * 60),
        (.shortBreak, 5 * 60),
        (.pomodoro, 25 * 60),
        (.shortBreak, 5 * 60),
        (.pomodoro, 25 * 60),
        (.longBreak, 15 * 60)
    ]

    private var totalCycleLength: TimeInterval {
        return pomodoroCycle.reduce(0) { $0 + $1.1 }
    }

    private var currentSegmentInfo: (PomSegmentType, TimeInterval, TimeInterval) {
        let cycleTime = totalElapsedTime.truncatingRemainder(dividingBy: totalCycleLength)

        var accumulated: TimeInterval = 0
        for (segmentType, length) in pomodoroCycle {
            let nextAccumulated = accumulated + length
            if cycleTime < nextAccumulated {
                let timeInSegment = cycleTime - accumulated
                let remaining = length - timeInSegment
                return (segmentType, timeInSegment, remaining)
            }
            accumulated = nextAccumulated
        }

        return (.pomodoro, 0, 25 * 60)
    }

    private var currentTimerTypeName: String {
        _ = dummyTick
        return currentSegmentInfo.0.rawValue.uppercased()
    }

    private var timeRemainingInSegment: TimeInterval {
        _ = dummyTick
        return currentSegmentInfo.2
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(currentTimerTypeName)
                .font(.system(size: 21, weight: .bold, design: .rounded))
                .themedForeground(using: theme, in: colorScheme, level: 1, category: .secondary)
                .id(currentTimerTypeName)
                .transition(.asymmetric(insertion: .move(edge: .top).combined(with: .opacity),
                                        removal: .move(edge: .bottom).combined(with: .opacity)))
                .animation(.snappy(duration: 0.4), value: currentTimerTypeName)

            Text(formatTime(Int(timeRemainingInSegment)))
                .font(.system(size: 64, weight: .bold, design: .monospaced))
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.5))
                .fixedSize()
                .lineLimit(1)
                .padding(.top, 20)
                .padding(.bottom, 8)
                .id(currentTimerTypeName)
                .transition(.scale.combined(with: .opacity))
                .animation(.snappy(duration: 0.4), value: currentTimerTypeName)

            Spacer()

            HStack(spacing: 16) {
                if pomodoroState != .initial {
                    Button(action: {
                        withAnimation(.snappy(duration: 0.4)) {
                            resetTimer()
                        }
                    }) {
                        Text("Reset")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 10)
                            .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2.5))
                            .cornerRadius(16)
                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                    }
                    .gesture(DragGesture().onChanged { _ in })
                }

                Button(action: {
                    withAnimation(.snappy(duration: 0.4)) {
                        handleMainButtonTap()
                    }
                }) {
                    Text(mainButtonTitle)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2))
                        .cornerRadius(16)
                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                }
                .gesture(DragGesture().onChanged { _ in })

                if pomodoroState != .initial {
                    Button(action: {
                        withAnimation(.snappy(duration: 0.3)) {
                            skipSegment()
                        }
                    }) {
                        Text("Skip")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 10)
                            .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2.5))
                            .cornerRadius(16)
                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                    }
                    .gesture(DragGesture().onChanged { _ in })
                }
            }
            .themedForeground(using: theme, in: colorScheme, level: 5, category: .secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(timer) { _ in
            if pomodoroState == .running {
                // Force SwiftUI to re-render
                dummyTick.toggle()

                // If we've completed the current segment (<= 0), auto-skip
                if timeRemainingInSegment <= 0 {
                    skipSegment()
                }
            }
        }
    }

    // MARK: - Action Helpers

    private var mainButtonTitle: String {
        switch pomodoroState {
        case .initial: return "Start"
        case .running: return "Pause"
        case .paused: return "Resume"
        }
    }

    private func handleMainButtonTap() {
        switch pomodoroState {
        case .initial:
            // Start from zero
            saveState(
                PomodoroTimerStorage(
                    state: .running,
                    startDate: Date(),
                    accumulatedTime: 0
                )
            )
        case .running:
            // Pause
            let newAccumulated = totalElapsedTime
            saveState(
                PomodoroTimerStorage(
                    state: .paused,
                    startDate: nil,
                    accumulatedTime: newAccumulated
                )
            )
        case .paused:
            // Resume
            saveState(
                PomodoroTimerStorage(
                    state: .running,
                    startDate: Date(),
                    accumulatedTime: accumulatedTime // keep whatever we've got so far
                )
            )
        }
    }

    /// Skips the remainder of the current segment.
    private func skipSegment() {
        // If we're in the middle of a segment, add the leftover so we jump to next.
        let leftover = timeRemainingInSegment
        let newAccumulated = totalElapsedTime + leftover

        // Keep the same state (running or paused). If paused, we still jump segments but remain paused.
        switch pomodoroState {
        case .initial:
            // If user taps 'Skip' in .initial for some reason, interpret as "start" then skip?
            // Or do nothing. It's your choice; here's a no-op:
            break
        case .running:
            saveState(
                PomodoroTimerStorage(
                    state: .running,
                    startDate: Date(), // new start now
                    accumulatedTime: newAccumulated
                )
            )
        case .paused:
            saveState(
                PomodoroTimerStorage(
                    state: .paused,
                    startDate: nil,
                    accumulatedTime: newAccumulated
                )
            )
        }
    }

    private func resetTimer() {
        // Clears everything back to initial
        saveState(
            PomodoroTimerStorage(
                state: .initial,
                startDate: nil,
                accumulatedTime: 0
            )
        )
    }

    /// Saves new pomodoro data back to the environment’s window `saveData`.
    private func saveState(_ newState: PomodoroTimerStorage) {
        guard let encoded = try? JSONEncoder().encode(newState),
              let jsonString = String(data: encoded, encoding: .utf8),
              let index = space.windows.firstIndex(where: { $0.id == windowId })
        else { return }

        space.windows[index].data.saveData["pomodoroState"] = jsonString
    }

    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}
