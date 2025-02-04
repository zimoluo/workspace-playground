import SwiftUI

struct WritingPrompt: Identifiable {
    let id = UUID()
    let text: String
}

class DailyWritingPromptViewModel: ObservableObject {
    @Published var prompt: WritingPrompt

    private let prompts: [WritingPrompt] = [
        WritingPrompt(text: "Reflect on a moment of disappointment. What did you learn?"),
        WritingPrompt(text: "Recall when you felt misunderstood. How did you respond?"),
        WritingPrompt(text: "Think of a decision you later questioned. What did it reveal?"),
        WritingPrompt(text: "Remember a time you stepped outside your comfort zone. What changed?"),
        WritingPrompt(text: "Describe a moment of deep self-connection. How did it impact you?"),
        WritingPrompt(text: "Reflect on an act of forgiveness—either given or received. What shifted?"),
        WritingPrompt(text: "Consider a belief you once held. How has your perspective evolved?")
    ]

    private var timer: Timer?

    init() {
        self.prompt = DailyWritingPromptViewModel.prompt(for: Date(), from: prompts)
        scheduleNextRefresh()
    }

    static func prompt(for date: Date, from prompts: [WritingPrompt]) -> WritingPrompt {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0

        // Use the previous day's prompt if it's before 3:30 AM
        var effectiveDate = date
        if hour < 3 || (hour == 3 && minute < 30) {
            effectiveDate = calendar.date(byAdding: .day, value: -1, to: date)!
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: effectiveDate)
        let hashValue = dateString.hashValue
        let index = abs(hashValue) % prompts.count

        return prompts[index]
    }

    private func scheduleNextRefresh() {
        let calendar = Calendar.current
        let now = Date()

        var nextRefreshComponents = calendar.dateComponents([.year, .month, .day], from: now)
        nextRefreshComponents.hour = 3
        nextRefreshComponents.minute = 30
        nextRefreshComponents.second = 0

        var nextRefresh = calendar.date(from: nextRefreshComponents)!
        if now >= nextRefresh {
            nextRefresh = calendar.date(byAdding: .day, value: 1, to: nextRefresh)!
        }
        let interval = nextRefresh.timeIntervalSince(now)

        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.prompt = DailyWritingPromptViewModel.prompt(for: Date(), from: self.prompts)
            self.scheduleNextRefresh()
        }
    }

    deinit {
        timer?.invalidate()
    }
}

struct DailyWritingPromptView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @StateObject private var viewModel = DailyWritingPromptViewModel()

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.prompt.text)
                    .font(.system(size: geometry.size.width * 0.075, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 12)
                    .themedForeground(using: theme, in: colorScheme, category: .secondary)
            }
            .padding(.vertical, 12)
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
