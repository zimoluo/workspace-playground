import SwiftUI

struct DigitalClock: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    private let time = Calendar.current.date(from: DateComponents(hour: 10, minute: 10, second: 30))!
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shorterSide: CGFloat = geometry.size.width
                let fontSize: CGFloat = shorterSide * 0.3
                Color.clear.ignoresSafeArea()
                
                HStack(spacing: shorterSide * 0.034) {
                    DigitalNumber(number: hour, fontSize: fontSize)
                    
                    Text(":")
                        .font(.system(size: fontSize * 0.75, weight: .bold, design: .monospaced))
                        .fixedSize()
                        .frame(width: shorterSide * 0.1)
                        .opacity(Calendar.current.component(.second, from: time) % 2 == 0 ? 1 : 0.33)
                    
                    DigitalNumber(number: minute, fontSize: fontSize)
                }
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                .frame(width: shorterSide)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private var hour: Int {
        let hour = Calendar.current.component(.hour, from: time)
        return hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour)
    }
    
    private var minute: Int {
        Calendar.current.component(.minute, from: time)
    }
}

struct DigitalNumber: View {
    let number: Int
    var fontSize: CGFloat
    
    var body: some View {
        Text(String(format: "%02d", number))
            .font(.system(size: fontSize, weight: .bold, design: .monospaced))
            .fixedSize()
            .frame(width: fontSize * 1.2)
            .transition(.scale.combined(with: .opacity))
            .id(number)
    }
}

#Preview {
    ZStack {
        DigitalClock()
    }
}
