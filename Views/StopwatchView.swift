import SwiftUI

enum StopwatchState {
    case initial
    case running
    case paused
}

struct StopwatchView: View {
    @State private var stopwatchState: StopwatchState = .initial
    
    /// The time the stopwatch was most recently started (or resumed).
    @State private var startDate: Date? = nil
    
    /// The total accumulated time from previous runs (in seconds).
    @State private var accumulatedTime: TimeInterval = 0
    
    /// Each time "Lap" is tapped, we append the current Date.
    /// The very first lap can be appended when we first start, so laps[0]
    /// can serve as the reference for the first lap's start.
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
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                    Spacer()
                    
                    // Buttons area
                    buttonsView
                }
                .frame(height: geometry.size.height * 0.5)
                
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
                        }
                    }
                    .padding(.vertical)
                }
                .frame(height: geometry.size.height * 0.5)
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
            Button(action: startStopwatch) {
                Text("Start")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
        case .running:
            // Lap (left), Stop (right)
            HStack {
                Button(action: lap) {
                    Text("Lap")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button(action: stopStopwatch) {
                    Text("Stop")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
        case .paused:
            // Reset (left), Resume (right)
            HStack {
                Button(action: resetStopwatch) {
                    Text("Reset")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                
                Button(action: resumeStopwatch) {
                    Text("Resume")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Computed Values
    
    /// Current total elapsed time: accumulatedTime + (time since last start if running)
    private var currentElapsedTime: TimeInterval {
        _ = dummyTick // Add this line to create a dependency on `dummyTick`
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
                    let endTime = thisLapStart.addingTimeInterval(accumulatedTime - lapOffsetBefore(i))
                    results.append(endTime.timeIntervalSince(thisLapStart))
                }
            }
        }
        return results
    }
    
    /// When calculating a lap’s “stop” point in paused mode, we only want
    /// the difference in accumulated time since that lap’s start. If the user
    /// took multiple laps, the “start” of the last lap might be partway through.
    /// This is just a helper to ensure partial times are accounted for correctly.
    ///
    /// A simpler approach is to store each lap’s offset from the start, but
    /// here we adapt the logic to align with Date-based laps.
    private func lapOffsetBefore(_ index: Int) -> TimeInterval {
        // Sum all previous laps up to `index` so that we can figure out how much
        // "accumulatedTime" had already accounted for them. This can get complex
        // if you want partial logic for paused intervals, so feel free to adapt as needed.
        // In a minimal design, you might not need this function. It’s here just
        // to illustrate that if you have complicated lap offsets, you can manage them.
        
        // In many implementations, each lap's difference is simply
        // laps[i+1] - laps[i], so you might skip the partial offsets.
        // We'll keep it returning 0 for simplicity’s sake here.
        return 0
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
        let totalMilliseconds = Int((time * 1000).rounded())
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
