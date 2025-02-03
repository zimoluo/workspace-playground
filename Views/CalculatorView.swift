import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var space: Space
    @Environment(\.windowId) var windowId: UUID
    
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    struct CalculatorData: Codable {
        var previousExpression: String
        var currentDisplay: String
        var tokens: [String]
        var currentInput: String
    }
    
    var body: some View {
        let data = loadCalcData()
        
        return GeometryReader { geometry in
            let spacing: CGFloat = 8
            let normalButtonWidth = (geometry.size.width - spacing * 5) / 4
            let fixedButtonHeight: CGFloat = 40
            
            VStack(spacing: spacing) {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    if !data.previousExpression.isEmpty {
                        Text(data.previousExpression)
                            .font(.system(size: 17, weight: .medium, design: .monospaced))
                            .foregroundStyle(theme.secondary.shadeMap(numShades: 40).shadeMap[6].color)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.trailing)
                    }
                    Text(data.currentDisplay)
                        .font(.system(size: 24, weight: .medium, design: .monospaced))
                        .foregroundStyle(theme.secondary.shadeMap(numShades: 40).shadeMap[0].color)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.horizontal, spacing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                VStack(spacing: spacing) {
                    HStack(spacing: spacing) {
                        CalculatorButton(
                            title: "AC",
                            backgroundColor: theme.secondary.shadeMap(numShades: 40).shadeMap[16].color,
                            normalWidth: normalButtonWidth,
                            spacing: spacing,
                            buttonHeight: fixedButtonHeight,
                            action: handleInput
                        )
                        CalculatorButton(
                            title: "+/-",
                            backgroundColor: theme.secondary.shadeMap(numShades: 40).shadeMap[16].color,
                            normalWidth: normalButtonWidth,
                            spacing: spacing,
                            buttonHeight: fixedButtonHeight,
                            action: handleInput
                        )
                        CalculatorButton(
                            title: "%",
                            backgroundColor: theme.secondary.shadeMap(numShades: 40).shadeMap[16].color,
                            normalWidth: normalButtonWidth,
                            spacing: spacing,
                            buttonHeight: fixedButtonHeight,
                            action: handleInput
                        )
                        CalculatorButton(
                            title: "÷",
                            backgroundColor: theme.tertiary.shadeMap(numShades: 40).shadeMap[15].color,
                            normalWidth: normalButtonWidth,
                            spacing: spacing,
                            buttonHeight: fixedButtonHeight,
                            action: handleInput
                        )
                    }
                    HStack(spacing: spacing) {
                        CalculatorButton("7", normalButtonWidth, spacing, fixedButtonHeight, handleInput)
                        CalculatorButton("8", normalButtonWidth, spacing, fixedButtonHeight, handleInput)
                        CalculatorButton("9", normalButtonWidth, spacing, fixedButtonHeight, handleInput)
                        CalculatorButton(
                            title: "×",
                            backgroundColor: theme.tertiary.shadeMap(numShades: 40).shadeMap[15].color,
                            normalWidth: normalButtonWidth,
                            spacing: spacing,
                            buttonHeight: fixedButtonHeight,
                            action: handleInput
                        )
                    }
                    HStack(spacing: spacing) {
                        CalculatorButton("4", normalButtonWidth, spacing, fixedButtonHeight, handleInput)
                        CalculatorButton("5", normalButtonWidth, spacing, fixedButtonHeight, handleInput)
                        CalculatorButton("6", normalButtonWidth, spacing, fixedButtonHeight, handleInput)
                        CalculatorButton(
                            title: "−",
                            backgroundColor: theme.tertiary.shadeMap(numShades: 40).shadeMap[15].color,
                            normalWidth: normalButtonWidth,
                            spacing: spacing,
                            buttonHeight: fixedButtonHeight,
                            action: handleInput
                        )
                    }
                    HStack(spacing: spacing) {
                        CalculatorButton("1", normalButtonWidth, spacing, fixedButtonHeight, handleInput)
                        CalculatorButton("2", normalButtonWidth, spacing, fixedButtonHeight, handleInput)
                        CalculatorButton("3", normalButtonWidth, spacing, fixedButtonHeight, handleInput)
                        CalculatorButton(
                            title: "+",
                            backgroundColor: theme.tertiary.shadeMap(numShades: 40).shadeMap[15].color,
                            normalWidth: normalButtonWidth,
                            spacing: spacing,
                            buttonHeight: fixedButtonHeight,
                            action: handleInput
                        )
                    }
                    HStack(spacing: spacing) {
                        CalculatorButton(
                            title: "0",
                            isWide: true,
                            normalWidth: normalButtonWidth,
                            spacing: spacing,
                            buttonHeight: fixedButtonHeight,
                            action: handleInput
                        )
                        CalculatorButton(".", normalButtonWidth, spacing, fixedButtonHeight, handleInput)
                        CalculatorButton(
                            title: "=",
                            backgroundColor: theme.tertiary.shadeMap(numShades: 40).shadeMap[15].color,
                            normalWidth: normalButtonWidth,
                            spacing: spacing,
                            buttonHeight: fixedButtonHeight,
                            action: handleInput
                        )
                    }
                }
                .padding(.bottom, spacing * 1.5)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .edgesIgnoringSafeArea(.all)
        .background(
            LinearGradient(
                colors: [
                    theme.secondary.shadeMap(numShades: 40).shadeMap[36].color,
                    theme.secondary.shadeMap(numShades: 40).shadeMap[31].color
                ],
                startPoint: .bottom,
                endPoint: .top
            )
        )
    }
    
    private func loadCalcData() -> CalculatorData {
        guard let wIndex = space.windows.firstIndex(where: { $0.id == windowId }) else {
            return CalculatorData(previousExpression: "", currentDisplay: "0", tokens: [], currentInput: "")
        }
        
        let w = space.windows[wIndex]
        if
            let jsonString = w.data.saveData["CalculatorData"],
            let rawData = jsonString.data(using: .utf8),
            let decoded = try? JSONDecoder().decode(CalculatorData.self, from: rawData)
        {
            return decoded
        } else {
            return CalculatorData(previousExpression: "", currentDisplay: "0", tokens: [], currentInput: "")
        }
    }
    
    private func saveCalcData(_ newData: CalculatorData) {
        guard let wIndex = space.windows.firstIndex(where: { $0.id == windowId }) else { return }
        var w = space.windows[wIndex]
        
        if let encoded = try? JSONEncoder().encode(newData),
           let jsonString = String(data: encoded, encoding: .utf8)
        {
            w.data.saveData["CalculatorData"] = jsonString
            space.windows[wIndex] = w
        }
    }
    
    private func handleInput(_ input: String) {
        var c = loadCalcData()
        
        switch input {
        case "AC":
            c = clear(c)
        case "+/-":
            c = toggleSign(c)
        case "%":
            c = applyPercentage(c)
        case "+", "−", "×", "÷":
            c = inputOperator(input, c)
        case "=":
            c = evaluate(c)
        default:
            c = inputDigit(input, c)
        }
        
        saveCalcData(c)
    }
    
    private func inputDigit(_ digit: String, _ data: CalculatorData) -> CalculatorData {
        var d = data
        
        if !d.previousExpression.isEmpty {
            d.previousExpression = ""
            d.tokens = []
            d.currentInput = ""
            d.currentDisplay = "0"
        }
        
        if digit == "." {
            if d.currentInput.contains(".") { return d }
            if d.currentInput.isEmpty { d.currentInput = "0" }
        }
        
        d.currentInput.append(digit)
        d = updateCurrentDisplay(d)
        return d
    }
    
    private func inputOperator(_ op: String, _ data: CalculatorData) -> CalculatorData {
        var d = data
        if !d.previousExpression.isEmpty {
            d.previousExpression = ""
            d.tokens = [d.currentDisplay]
            d.currentInput = ""
        } else {
            if !d.currentInput.isEmpty {
                d.tokens.append(d.currentInput)
                d.currentInput = ""
            }
        }
        
        if let last = d.tokens.last, isOperator(last) {
            d.tokens[d.tokens.count - 1] = op
        } else {
            d.tokens.append(op)
        }
        d = updateCurrentDisplay(d)
        return d
    }
    
    private func clear(_ data: CalculatorData) -> CalculatorData {
        return CalculatorData(previousExpression: "", currentDisplay: "0", tokens: [], currentInput: "")
    }
    
    private func toggleSign(_ data: CalculatorData) -> CalculatorData {
        var d = data
        
        if !d.previousExpression.isEmpty {
            d.previousExpression = ""
        }
        
        if !d.currentInput.isEmpty {
            if d.currentInput.first == "-" {
                d.currentInput.removeFirst()
            } else {
                d.currentInput = "-" + d.currentInput
            }
        } else if let last = d.tokens.last, !isOperator(last) {
            if last.first == "-" {
                d.tokens[d.tokens.count - 1] = String(last.dropFirst())
            } else {
                d.tokens[d.tokens.count - 1] = "-" + last
            }
        }
        d = updateCurrentDisplay(d)
        return d
    }
    
    private func applyPercentage(_ data: CalculatorData) -> CalculatorData {
        var d = data
        
        if !d.previousExpression.isEmpty {
            d.previousExpression = ""
        }
        
        if !d.currentInput.isEmpty, let value = Double(d.currentInput) {
            let percentValue = value / 100
            d.currentInput = String(percentValue)
        } else if let last = d.tokens.last, let value = Double(last) {
            let percentValue = value / 100
            d.tokens[d.tokens.count - 1] = String(percentValue)
        }
        d = updateCurrentDisplay(d)
        return d
    }
    
    private func evaluate(_ data: CalculatorData) -> CalculatorData {
        var d = data
        
        if !d.currentInput.isEmpty {
            d.tokens.append(d.currentInput)
            d.currentInput = ""
        }
        d.previousExpression = d.tokens.joined(separator: "")
        
        let result = evaluateTokens(d.tokens)
        d.currentDisplay = result.clean
        
        d.tokens = []
        d.currentInput = result.clean
        return d
    }
    
    private func updateCurrentDisplay(_ data: CalculatorData) -> CalculatorData {
        var d = data
        if d.tokens.isEmpty && d.currentInput.isEmpty {
            d.currentDisplay = "0"
        } else {
            d.currentDisplay = d.tokens.joined(separator: "") + d.currentInput
        }
        return d
    }
    
    private func isOperator(_ token: String) -> Bool {
        return token == "+" || token == "−" || token == "×" || token == "÷"
    }
    
    private func evaluateTokens(_ tokens: [String]) -> Double {
        var newTokens = [String]()
        var i = 0
        
        while i < tokens.count {
            let token = tokens[i]
            if token == "×" || token == "÷" {
                if
                    let left = Double(newTokens.removeLast()),
                    i + 1 < tokens.count,
                    let right = Double(tokens[i + 1])
                {
                    let computed = (token == "×") ? (left * right) : (left / right)
                    newTokens.append(String(computed))
                    i += 2
                } else {
                    return 0
                }
            } else {
                newTokens.append(token)
                i += 1
            }
        }
        
        var result = 0.0
        if let first = newTokens.first, let firstVal = Double(first) {
            result = firstVal
        }
        i = 1
        while i < newTokens.count {
            let op = newTokens[i]
            if i + 1 < newTokens.count, let nextVal = Double(newTokens[i + 1]) {
                if op == "+" {
                    result += nextVal
                } else if op == "−" {
                    result -= nextVal
                }
            }
            i += 2
        }
        return result
    }
}

extension Double {
    var clean: String {
        truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", self)
            : String(self)
    }
}

struct CalculatorButton: View {
    @Environment(\.theme) private var theme
    
    let title: String
    var backgroundColor: Color?
    var isWide: Bool = false
    let normalWidth: CGFloat
    let spacing: CGFloat
    let buttonHeight: CGFloat
    let action: (String) -> Void
    
    var body: some View {
        Button(action: { action(title) }) {
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .monospaced))
                .frame(width: isWide ? normalWidth * 2 + spacing : normalWidth,
                       height: buttonHeight)
                .foregroundStyle(theme.secondary.shadeMap(numShades: 40).shadeMap[0].color)
                .background(backgroundColor ?? theme.secondary.shadeMap(numShades: 40).shadeMap[26].color)
                .cornerRadius(buttonHeight / 2)
        }
        .gesture(DragGesture().onChanged { _ in })
    }
}

private extension CalculatorButton {
    init(_ title: String,
         _ normalWidth: CGFloat,
         _ spacing: CGFloat,
         _ buttonHeight: CGFloat,
         _ action: @escaping (String) -> Void)
    {
        self.init(
            title: title,
            normalWidth: normalWidth,
            spacing: spacing,
            buttonHeight: buttonHeight,
            action: action
        )
    }
}
