import SwiftUI

struct Quote: Identifiable {
    let id = UUID()
    let text: String
    let author: String
}

class DailyQuoteViewModel: ObservableObject {
    @Published var quote: Quote

    private let quotes: [Quote] = [
        Quote(text: "Innovation distinguishes between a leader and a follower.", author: "Steve Jobs"),
        Quote(text: "Stay hungry, stay foolish.", author: "Steve Jobs"),
        Quote(text: "Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work.", author: "Steve Jobs"),
        Quote(text: "Have the courage to follow your heart and intuition. They somehow already know what you truly want to become.", author: "Steve Jobs"),
        Quote(text: "Things don't have to change the world to be important.", author: "Steve Jobs"),
        Quote(text: "I’m as proud of many of the things we haven’t done as the things we have done.", author: "Steve Jobs"),
        Quote(text: "We hire smart people so they can tell us what to do.", author: "Steve Jobs"),
        Quote(text: "People don’t know what they want until you show it to them.", author: "Steve Jobs"),
        Quote(text: "I would rather gamble on our vision than make a 'me too' product.", author: "Steve Jobs"),

        Quote(text: "The most important thing is a person. A person who incites your curiosity and feeds your ideas. And a person you want to learn from.", author: "Jony Ive"),
        Quote(text: "There is beauty when something works and it works intuitively.", author: "Jony Ive"),

        Quote(text: "The sidelines are not where you want to live your life. The world needs you in the arena.", author: "Tim Cook"),
        Quote(text: "You want to be the pebble in the pond that creates the ripple for change.", author: "Tim Cook"),
        Quote(text: "We’re here to put a dent in the universe. Otherwise, why else even be here?", author: "Steve Jobs"),
    ]

    private var timer: Timer?

    init() {
        self.quote = DailyQuoteViewModel.quote(for: Date(), from: quotes)
        scheduleNextRefresh()
    }

    static func quote(for date: Date, from quotes: [Quote]) -> Quote {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0

        var effectiveDate = date
        if hour < 3 || (hour == 3 && minute < 30) {
            effectiveDate = calendar.date(byAdding: .day, value: -1, to: date)!
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: effectiveDate)
        let hashValue = dateString.hashValue
        let index = abs(hashValue) % quotes.count

        return quotes[index]
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
            self.quote = DailyQuoteViewModel.quote(for: Date(), from: self.quotes)
            self.scheduleNextRefresh()
        }
    }

    deinit {
        timer?.invalidate()
    }
}

struct DailyQuoteView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @StateObject private var viewModel = DailyQuoteViewModel()

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Text("“\(viewModel.quote.text)”")
                    .font(.system(size: geometry.size.width * 0.08, weight: .bold))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.6)
                    .padding(.horizontal, 12)
                    .themedForeground(using: theme, in: colorScheme, category: .secondary)

                Spacer()
                    .frame(maxHeight: 24)

                Text("- \(viewModel.quote.author)")
                    .font(.system(size: geometry.size.width * 0.05, weight: .medium))
                    .multilineTextAlignment(.center)
                    .themedForeground(using: theme, in: colorScheme, category: .secondary)
            }
            .padding(.vertical, 16)
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
