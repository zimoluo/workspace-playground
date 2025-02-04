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
        Quote(text: "It's not about money. It's about the people you have, how you're led, and how much you get it.", author: "Steve Jobs"),
        Quote(text: "Things don't have to change the world to be important.", author: "Steve Jobs"),
        Quote(text: "I’m as proud of many of the things we haven’t done as the things we have done.", author: "Steve Jobs"),
        Quote(text: "We hire smart people so they can tell us what to do.", author: "Steve Jobs"),
        Quote(text: "People don’t know what they want until you show it to them.", author: "Steve Jobs"),
        Quote(text: "I would rather gamble on our vision than make a 'me too' product.", author: "Steve Jobs"),

        Quote(text: "The most important thing is a person. A person who incites your curiosity and feeds your ideas. And a person you want to learn from.", author: "Jony Ive"),
        Quote(text: "Simplicity is not the absence of clutter, that's a consequence of simplicity. Simplicity is somehow essentially describing the purpose and place of an object and product.", author: "Jony Ive"),
        Quote(text: "There is beauty when something works and it works intuitively.", author: "Jony Ive"),

        Quote(text: "If something isn’t right, you can’t fix it later.", author: "Tim Cook"),
        Quote(text: "The sidelines are not where you want to live your life. The world needs you in the arena.", author: "Tim Cook"),
        Quote(text: "You want to be the pebble in the pond that creates the ripple for change.", author: "Tim Cook"),
        Quote(text: "We’re here to put a dent in the universe. Otherwise, why else even be here?", author: "Steve Jobs"),

        /*
            Quote(text: "Happiness depends upon ourselves.", author: "Aristotle"),
            Quote(text: "Knowing yourself is the beginning of all wisdom.", author: "Aristotle"),
            Quote(text: "The unexamined life is not worth living.", author: "Socrates"),
            Quote(text: "To find yourself, think for yourself.", author: "Socrates"),
            Quote(text: "An ounce of practice is worth more than tons of preaching.", author: "Mahatma Gandhi"),
            Quote(text: "The only true wisdom is in knowing you know nothing.", author: "Socrates"),
            Quote(text: "Do not dwell in the past, do not dream of the future, concentrate the mind on the present moment.", author: "Buddha"),
            Quote(text: "The mind is everything. What you think you become.", author: "Buddha"),
            Quote(text: "He who opens a school door, closes a prison.", author: "Victor Hugo"),
            Quote(text: "Freedom is nothing else but a chance to be better.", author: "Albert Camus"),
            Quote(text: "You must be the change you wish to see in the world.", author: "Mahatma Gandhi"),
            Quote(text: "Happiness is not something ready made. It comes from your own actions.", author: "Dalai Lama"),
            Quote(text: "We are what we repeatedly do. Excellence, then, is not an act, but a habit.", author: "Aristotle"),
            Quote(text: "There is only one way to avoid criticism: do nothing, say nothing, and be nothing.", author: "Aristotle"),
            Quote(text: "He who has a why to live can bear almost any how.", author: "Friedrich Nietzsche"),
            Quote(text: "Out of chaos comes order.", author: "Friedrich Nietzsche"),
            Quote(text: "God is dead. God remains dead. And we have killed him.", author: "Friedrich Nietzsche"),
            Quote(text: "The measure of a man is what he does with power.", author: "Plato"),
            Quote(text: "He who is not contented with what he has, would not be contented with what he would like to have.", author: "Socrates"),
            Quote(text: "No man has the right to be an amateur in the matter of physical training. It is a shame for a man to grow old without seeing the beauty and strength of which his body is capable.", author: "Socrates"),
            Quote(text: "The privilege of a lifetime is to become who you truly are.", author: "Carl Jung"),
            Quote(text: "Man is born free, and everywhere he is in chains.", author: "Jean-Jacques Rousseau"),
            Quote(text: "We do not see things as they are, we see them as we are.", author: "Anaïs Nin"),
            Quote(text: "Those who know do not speak. Those who speak do not know.", author: "Lao Tzu"),
            Quote(text: "When you are content to be simply yourself and don't compare or compete, everyone will respect you.", author: "Lao Tzu"),
            Quote(text: "Simplicity, patience, compassion. These three are your greatest treasures.", author: "Lao Tzu"),
            Quote(text: "Mastering others is strength. Mastering yourself is true power.", author: "Lao Tzu"),
            Quote(text: "Act without expectation.", author: "Lao Tzu"),
            Quote(text: "It is not length of life, but depth of life.", author: "Ralph Waldo Emerson"),
            Quote(text: "To be yourself in a world that is constantly trying to make you something else is the greatest accomplishment.", author: "Ralph Waldo Emerson"),
            Quote(text: "Do what you can, with what you have, where you are.", author: "Theodore Roosevelt"),
            Quote(text: "The only thing I know is that I know nothing.", author: "Socrates"),
            Quote(text: "Wisely and slow. They stumble that run fast.", author: "William Shakespeare"),
            Quote(text: "Hell is other people.", author: "Jean-Paul Sartre"),
            Quote(text: "One cannot step twice in the same river.", author: "Heraclitus"),
            Quote(text: "Even while they teach, men learn.", author: "Seneca"),
            Quote(text: "Difficulties strengthen the mind, as labor does the body.", author: "Seneca"),
            Quote(text: "It is not that we have a short time to live, but that we waste a lot of it.", author: "Seneca"),
            Quote(text: "Luck is what happens when preparation meets opportunity.", author: "Seneca"),
            Quote(text: "We suffer more in imagination than in reality.", author: "Seneca"),
            Quote(text: "He who fears he will suffer, already suffers because he fears.", author: "Michel de Montaigne"),
            Quote(text: "We are more often frightened than hurt; and we suffer more from imagination than from reality.", author: "Seneca"),
            Quote(text: "The happiness of your life depends upon the quality of your thoughts.", author: "Marcus Aurelius"),
            Quote(text: "Everything we hear is an opinion, not a fact. Everything we see is a perspective, not the truth.", author: "Marcus Aurelius"),
            Quote(text: "You have power over your mind - not outside events. Realize this, and you will find strength.", author: "Marcus Aurelius")
             */
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

struct DailyQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        DailyQuoteView()
    }
}
