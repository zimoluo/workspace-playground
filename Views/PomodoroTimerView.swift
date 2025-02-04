import Combine
import SwiftUI

struct PomodoroTimerView: View {
    enum TimerType: String {
        case pomodoro = "Pomodoro"
        case shortBreak = "Short Break"
        case longBreak = "Long Break"
        
        var duration: Int {
            switch self {
            case .pomodoro: return 25 * 60
            case .shortBreak: return 5 * 60
            case .longBreak: return 15 * 60
            }
        }
    }
    
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var timerType: TimerType = .pomodoro
    @State private var timeRemaining: Int = TimerType.pomodoro.duration
    @State private var isRunning = false
    
    @State private var pomodoroCount = 0
    
    @State private var targetDate: Date? = nil
    
    private let timerPublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Text(timerType.rawValue.uppercased())
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .themedForeground(using: theme, in: colorScheme, level: 1, category: .secondary)
                
                Text(timeString(from: timeRemaining))
                    .font(.system(size: 64, weight: .bold, design: .monospaced))
                    .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.33))
                    .fixedSize()
                    .lineLimit(1)
                    .padding(.top, 20)
                    .padding(.bottom, 8)
                
                Spacer()
                
                HStack(spacing: 16) {
                    if isRunning || timeRemaining != timerType.duration {
                        Button(action: {
                            withAnimation(.snappy(duration: 0.3)) {
                                resetTimer()
                            }
                        }) {
                            Text("Reset")
                                .font(.system(size: 16, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 10)
                                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2.5))
                                .cornerRadius(16)
                                .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                        }
                    }
                        
                    Button(action: {
                        if isRunning {
                            withAnimation(.snappy(duration: 0.3)) {
                                pauseTimer()
                            }
                        } else {
                            withAnimation(.snappy(duration: 0.3)) {
                                startTimer()
                            }
                        }
                    }) {
                        Text(isRunning ? "Pause" : "Start")
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 10)
                            .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2))
                            .cornerRadius(16)
                            .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                    }
                        
                    if isRunning || timeRemaining != timerType.duration {
                        Button(action: {
                            withAnimation(.snappy(duration: 0.3)) {
                                skipTimer()
                            }
                        }) {
                            Text("Skip")
                                .font(.system(size: 16, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 10)
                                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2.5))
                                .cornerRadius(16)
                                .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                        }
                    }
                }
                .themedForeground(using: theme, in: colorScheme, level: 5, category: .secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onReceive(timerPublisher) { _ in
                timerTick()
            }
        }
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
    
    func startTimer() {
        isRunning = true
        targetDate = Date().addingTimeInterval(TimeInterval(timeRemaining))
    }
    
    func pauseTimer() {
        if let target = targetDate {
            timeRemaining = max(0, Int(target.timeIntervalSinceNow))
        }
        isRunning = false
        targetDate = nil
    }
    
    func resetTimer() {
        pauseTimer()
        timerType = .pomodoro
        timeRemaining = timerType.duration
        pomodoroCount = 0
    }
    
    func skipTimer() {
        pauseTimer()
        moveToNextTimer()
        startTimer()
    }
    
    func timerTick() {
        guard let target = targetDate else { return }
        let remaining = max(0, Int(target.timeIntervalSinceNow))
        timeRemaining = remaining
        
        if remaining == 0 {
            pauseTimer()
            moveToNextTimer()
            startTimer()
        }
    }
    
    func moveToNextTimer() {
        if timerType == .pomodoro {
            pomodoroCount += 1
            if pomodoroCount % 4 == 0 {
                timerType = .longBreak
            } else {
                timerType = .shortBreak
            }
        } else {
            timerType = .pomodoro
        }
        timeRemaining = timerType.duration
    }
}

struct PomodoroTimerView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroTimerView()
    }
}
