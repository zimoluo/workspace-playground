import CryptoKit
import SwiftUI

struct Quote: Identifiable {
    let id = UUID()
    let text: String
    let author: String
}

class DailyQuoteViewModel: ObservableObject {
    @Published var quote: Quote

    private let quotes: [Quote] = [
        Quote(text: "Have the courage to follow your heart and intuition. They somehow already know what you truly want to become.", author: "Steve Jobs")
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
        let hashData = Data(dateString.utf8)
        let digest = SHA256.hash(data: hashData)

        let hashInt = digest.withUnsafeBytes { ptr -> UInt64 in
            return ptr.load(as: UInt64.self)
        }

        let index = Int(hashInt % UInt64(quotes.count))

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
                    .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.5))

                Spacer()
                    .frame(maxHeight: 24)

                Text("- \(viewModel.quote.author)")
                    .font(.system(size: geometry.size.width * 0.05, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 0.5))
            }
            .padding(.vertical, 16)
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
