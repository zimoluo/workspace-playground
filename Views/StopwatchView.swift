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
    
    @State private var laps: [Date] = []
    
    /// We use this dummy toggle to force frequent UI updates while running.
    /// Every time the timer fires, we flip it; SwiftUI sees a change and re-renders.
    @State private var dummyTick = false
    
    private let timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Top half: large stopwatch display
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
                    
                    // Buttons area
                    buttonsView
                }
                .frame(height: (geometry.size.width * 0.5).clamped(to: 100 ... 180))
                .frame(maxWidth: .infinity)
                .padding(.bottom, 12)
                
                // Bottom half: laps list in reverse order
                Divider()
                ScrollView {
                    VStack(spacing: 8) {
                        // We'll generate each lap row from newest -> oldest by reversing
                        ForEach(Array(zip(lapTimes.indices, lapTimes)).reversed(), id: \.0) { index, timeInterval in
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
            // Force a view update only while the stopwatch is running
            if stopwatchState == .running {
                dummyTick.toggle()
            }
        }
    }
    
    // MARK: - Subviews
    
    /// The buttons that change based on stopwatch state
    @ViewBuilder
    private var buttonsView: some View {
        switch stopwatchState {
        case .initial:
            // Single large Start button
            HStack {
                Button(action: {
                    withAnimation(.spring(duration: 0.3)) {
                        startStopwatch()
                    }
                }) {
                    Text("Start")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(9)
                        .frame(maxWidth: 300)
                        .foregroundColor(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                        .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                        .cornerRadius(16)
                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                }
            }
            .padding(.horizontal, 16)
            
        case .running:
            // Lap (left), Stop (right)
            HStack(spacing: 12) {
                Button(action: { withAnimation(.spring(duration: 0.3)) {
                    lap()
                }}) {
                    Text("Lap")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(9)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                        .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2))
                        .cornerRadius(16)
                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                }
                
                Button(action: {
                    withAnimation(.spring(duration: 0.3)) {
                        stopStopwatch()
                    }
                }) {
                    Text("Stop")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(9)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(themeColor(from: theme, for: .tertiary, in: colorScheme, level: 5))
                        .background(themeColor(from: theme, for: .tertiary, in: colorScheme, level: 1))
                        .cornerRadius(16)
                        .shadow(color: theme.tertiary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                }
            }
            .padding(.horizontal)
            
        case .paused:
            // Reset (left), Resume (right)
            HStack(spacing: 12) {
                Button(action: {
                    withAnimation(.spring(duration: 0.3)) {
                        resetStopwatch()
                    }
                }) {
                    Text("Reset")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(9)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(themeColor(from: theme, for: .tertiary, in: colorScheme, level: 5))
                        .background(themeColor(from: theme, for: .tertiary, in: colorScheme, level: 2))
                        .cornerRadius(16)
                        .shadow(color: theme.tertiary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                }
                
                Button(action: {
                    withAnimation(.spring(duration: 0.3)) {
                        resumeStopwatch()
                    }
                }) {
                    Text("Resume")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(9)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                        .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                        .cornerRadius(16)
                        .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Computed Values
    
    /// Current total elapsed time: accumulatedTime + (time since last start if running)
    private var currentElapsedTime: TimeInterval {
        _ = dummyTick // create a dependency on dummyTick
        guard stopwatchState == .running, let startDate else {
            return accumulatedTime
        }
        return accumulatedTime + Date().timeIntervalSince(startDate)
    }

    /// Each entry in laps marks the start of a lap.
    /// Lap n's time = laps[n+1] - laps[n], except for the last lap, which is:
    /// (now if running, else the time the stopwatch stopped) - laps[n].
    private var lapTimes: [TimeInterval] {
        guard !laps.isEmpty else { return [] }
        
        var results: [TimeInterval] = []
        for i in laps.indices {
            let thisLapStart = laps[i]
            
            if i < laps.count - 1 {
                // Subtract from the next lap’s Date
                let nextLapStart = laps[i + 1]
                results.append(nextLapStart.timeIntervalSince(thisLapStart))
            } else {
                // Last lap – measure up to "now" if running, or
                // up to the paused time (accumulatedTime + startDate).
                if stopwatchState == .running {
                    // Current time
                    results.append(Date().timeIntervalSince(thisLapStart))
                } else {
                    // The time we “stopped” or “paused”
                    // = thisLapStart + leftover is the end
                    let endTime = thisLapStart.addingTimeInterval(accumulatedTime)
                    results.append(endTime.timeIntervalSince(thisLapStart))
                }
            }
        }
        return results
    }
    
    // MARK: - Actions
    
    private func startStopwatch() {
        startDate = Date()
        accumulatedTime = 0
        laps = [startDate!] // Start our first lap
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
        laps.append(Date())
    }
    
    // MARK: - Helpers
    
    /// Simple time formatter: HH:MM:SS.mmm or MM:SS.mmm. Adjust as needed.
    private func formatTime(_ time: TimeInterval) -> String {
        let clampedTime = max(0, time)
        
        let maxMilliseconds = (99 * 3600000) + (59 * 60000) + (59 * 1000) + 999 // 99:59:59.999 cap
        let totalMilliseconds = min(Int((clampedTime * 1000).rounded()), maxMilliseconds)
        
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
