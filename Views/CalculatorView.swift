import SwiftUI

class CalculatorViewModel: ObservableObject {
    @Published var previousExpression: String = ""
    @Published var currentDisplay: String = "0"
    
    private var tokens: [String] = []
    private var currentInput: String = ""
    
    private func updateCurrentDisplay() {
        if tokens.isEmpty && currentInput.isEmpty {
            currentDisplay = "0"
        } else {
            currentDisplay = tokens.joined(separator: "") + (currentInput.isEmpty ? "" : "" + currentInput)
        }
    }
    
    func handleInput(_ input: String) {
        switch input {
        case "AC":
            clear()
        case "+/-":
            toggleSign()
        case "%":
            applyPercentage()
        case "+", "−", "×", "÷":
            inputOperator(input)
        case "=":
            evaluate()
        default:
            inputDigit(input)
        }
    }
    
    func inputDigit(_ digit: String) {
        if !previousExpression.isEmpty {
            previousExpression = ""
            tokens = []
            currentInput = ""
            currentDisplay = "0"
        }
        if digit == "." {
            if currentInput.contains(".") { return }
            if currentInput.isEmpty { currentInput = "0" }
        }
        currentInput.append(digit)
        updateCurrentDisplay()
    }
    
    func inputOperator(_ op: String) {
        if !previousExpression.isEmpty {
            previousExpression = ""
            tokens = [currentDisplay]
            currentInput = ""
        } else {
            if !currentInput.isEmpty {
                tokens.append(currentInput)
                currentInput = ""
            }
        }
        if let last = tokens.last, isOperator(last) {
            tokens[tokens.count - 1] = op
        } else {
            tokens.append(op)
        }
        updateCurrentDisplay()
    }
    
    func clear() {
        tokens = []
        currentInput = ""
        previousExpression = ""
        currentDisplay = "0"
    }
    
    func toggleSign() {
        if !previousExpression.isEmpty {
            previousExpression = ""
            tokens = []
            currentInput = ""
            currentDisplay = "0"
        }
        if !currentInput.isEmpty {
            if currentInput.first == "-" {
                currentInput.removeFirst()
            } else {
                currentInput = "-" + currentInput
            }
        } else if let last = tokens.last, !isOperator(last) {
            if last.first == "-" {
                tokens[tokens.count - 1] = String(last.dropFirst())
            } else {
                tokens[tokens.count - 1] = "-" + last
            }
        }
        updateCurrentDisplay()
    }
    
    func applyPercentage() {
        if !previousExpression.isEmpty {
            previousExpression = ""
            tokens = []
            currentInput = ""
            currentDisplay = "0"
        }
        if !currentInput.isEmpty, let value = Double(currentInput) {
            let percentValue = value / 100
            currentInput = String(percentValue)
        } else if let last = tokens.last, let value = Double(last) {
            let percentValue = value / 100
            tokens[tokens.count - 1] = String(percentValue)
        }
        updateCurrentDisplay()
    }
    
    func evaluate() {
        if !currentInput.isEmpty {
            tokens.append(currentInput)
            currentInput = ""
        }
        previousExpression = tokens.joined(separator: "")
        let result = evaluateTokens(tokens)
        currentDisplay = result.clean
        tokens = []
        currentInput = result.clean
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
                if let left = Double(newTokens.removeLast()),
                   i + 1 < tokens.count,
                   let right = Double(tokens[i + 1])
                {
                    let computed: Double = token == "×" ? left * right : left / right
                    newTokens.append(String(computed))
                    i += 2
                    continue
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
        truncatingRemainder(dividingBy: 1) == 0 ?
            String(format: "%.0f", self) : String(self)
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

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    @Environment(\.theme) private var theme
    
    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = 8
            let normalButtonWidth = (geometry.size.width - spacing * 5) / 4
            let fixedButtonHeight: CGFloat = 40
            
            VStack(spacing: spacing) {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    if !viewModel.previousExpression.isEmpty {
                        Text(viewModel.previousExpression)
                            .font(.system(size: 17, weight: .medium, design: .monospaced))
                            .foregroundStyle(theme.secondary.shadeMap(numShades: 40).shadeMap[6].color)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.trailing)
                    }
                    Text(viewModel.currentDisplay)
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
                        CalculatorButton(title: "AC",
                                         backgroundColor: theme.secondary.shadeMap(numShades: 40).shadeMap[16].color,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "+/-",
                                         backgroundColor: theme.secondary.shadeMap(numShades: 40).shadeMap[16].color,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "%",
                                         backgroundColor: theme.secondary.shadeMap(numShades: 40).shadeMap[16].color,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "÷",
                                         backgroundColor: theme.tertiary.shadeMap(numShades: 40).shadeMap[15].color,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                    }
                    HStack(spacing: spacing) {
                        CalculatorButton(title: "7",
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "8",
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "9",
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "×",
                                         backgroundColor: theme.tertiary.shadeMap(numShades: 40).shadeMap[15].color,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                    }
                    HStack(spacing: spacing) {
                        CalculatorButton(title: "4",
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "5",
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "6",
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "−",
                                         backgroundColor: theme.tertiary.shadeMap(numShades: 40).shadeMap[15].color,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                    }
                    HStack(spacing: spacing) {
                        CalculatorButton(title: "1",
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "2",
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "3",
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "+",
                                         backgroundColor: theme.tertiary.shadeMap(numShades: 40).shadeMap[15].color,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                    }
                    HStack(spacing: spacing) {
                        CalculatorButton(title: "0",
                                         isWide: true,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: ".",
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "=",
                                         backgroundColor: theme.tertiary.shadeMap(numShades: 40).shadeMap[15].color,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                    }
                }
                .padding(.bottom, spacing * 1.5)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .edgesIgnoringSafeArea(.all)
        .background(LinearGradient(colors: [theme.secondary.shadeMap(numShades: 40).shadeMap[36].color, theme.secondary.shadeMap(numShades: 40).shadeMap[31].color], startPoint: .bottom, endPoint: .top))
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
