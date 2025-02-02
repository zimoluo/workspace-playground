import SwiftUI

// MARK: - Calculator View Model

/// A simple calculator view model that tokenizes input and evaluates the expression.
/// It maintains two published properties:
/// - previousExpression: Shown in a smaller font when a calculation has been made.
/// - currentDisplay: The main display area that shows the current input or result.
class CalculatorViewModel: ObservableObject {
    @Published var previousExpression: String = ""
    @Published var currentDisplay: String = "0"
    
    /// Tokens (numbers and operators) that have been entered.
    private var tokens: [String] = []
    /// The number currently being entered.
    private var currentInput: String = ""
    
    /// Updates the currentDisplay with the currently entered tokens.
    private func updateCurrentDisplay() {
        if tokens.isEmpty && currentInput.isEmpty {
            currentDisplay = "0"
        } else {
            currentDisplay = tokens.joined(separator: " ") + (currentInput.isEmpty ? "" : " " + currentInput)
        }
    }
    
    /// Dispatches input from a button press.
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
        default: // digits and decimal point
            inputDigit(input)
        }
    }
    
    /// When a digit (or ".") is pressed.
    func inputDigit(_ digit: String) {
        // If a result was just displayed, start a new expression.
        if !previousExpression.isEmpty {
            previousExpression = ""
            tokens = []
            currentInput = ""
            currentDisplay = "0"
        }
        if digit == "." {
            // Prevent multiple decimals.
            if currentInput.contains(".") { return }
            if currentInput.isEmpty { currentInput = "0" }
        }
        currentInput.append(digit)
        updateCurrentDisplay()
    }
    
    /// When an operator is pressed.
    func inputOperator(_ op: String) {
        // If a result is showing, start a new expression with the result as the first token.
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
        // If the last token is already an operator, replace it.
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
    
    /// Toggles the sign of the current input or the last token.
    func toggleSign() {
        // If a result is showing, start fresh.
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
    
    /// Applies percentage conversion to the current input or the last token.
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
    
    /// Evaluates the entered expression.
    func evaluate() {
        if !currentInput.isEmpty {
            tokens.append(currentInput)
            currentInput = ""
        }
        // Save the entered expression (without an equal sign) to the top line.
        previousExpression = tokens.joined(separator: " ")
        let result = evaluateTokens(tokens)
        currentDisplay = result.clean
        // Reset tokens, but let currentInput hold the result for further operations.
        tokens = []
        currentInput = result.clean
    }
    
    /// Checks whether a token is an operator.
    private func isOperator(_ token: String) -> Bool {
        return token == "+" || token == "−" || token == "×" || token == "÷"
    }
    
    /// Evaluates the tokenized expression in two passes.
    private func evaluateTokens(_ tokens: [String]) -> Double {
        // First pass: handle multiplication and division.
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
                    return 0 // Error handling could be expanded.
                }
            } else {
                newTokens.append(token)
                i += 1
            }
        }
        
        // Second pass: process addition and subtraction.
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

/// Formats a Double nicely (removes a trailing “.0” when possible).
extension Double {
    var clean: String {
        truncatingRemainder(dividingBy: 1) == 0 ?
            String(format: "%.0f", self) : String(self)
    }
}

// MARK: - Calculator Button View

/// A reusable calculator button view.
/// The width is computed adaptively from the parent’s geometry,
/// while the height is fixed.
struct CalculatorButton: View {
    let title: String
    var backgroundColor: Color = .init(.darkGray)
    var isWide: Bool = false
    /// The adaptive width for a standard button.
    let normalWidth: CGFloat
    /// The spacing value (used for computing the width of a wide button).
    let spacing: CGFloat
    /// The fixed height for all buttons.
    let buttonHeight: CGFloat
    /// Action to perform when the button is tapped.
    let action: (String) -> Void
    
    var body: some View {
        Button(action: { action(title) }) {
            Text(title)
                .font(.system(size: 32))
                .frame(width: isWide ? normalWidth * 2 + spacing : normalWidth,
                       height: buttonHeight)
                .foregroundColor(.white)
                .background(backgroundColor)
                .cornerRadius(buttonHeight / 2)
        }
    }
}

// MARK: - Calculator Main View

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            // Increase spacing between buttons.
            let spacing: CGFloat = 12
            // Compute the width for a standard button using available geometry.
            let normalButtonWidth = (geometry.size.width - spacing * 5) / 4
            // Set a fixed height for all buttons.
            let fixedButtonHeight: CGFloat = 80
            
            VStack(spacing: spacing) {
                // Display area.
                // When a result has been computed, the entered expression moves to the top.
                VStack(alignment: .trailing, spacing: 8) {
                    if !viewModel.previousExpression.isEmpty {
                        Text(viewModel.previousExpression)
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    Text(viewModel.currentDisplay)
                        .font(.system(size: 48))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.trailing)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                // Buttons grid.
                VStack(spacing: spacing) {
                    HStack(spacing: spacing) {
                        CalculatorButton(title: "AC",
                                         backgroundColor: .gray,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "+/-",
                                         backgroundColor: .gray,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "%",
                                         backgroundColor: .gray,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                        CalculatorButton(title: "÷",
                                         backgroundColor: .orange,
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
                                         backgroundColor: .orange,
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
                                         backgroundColor: .orange,
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
                                         backgroundColor: .orange,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                    }
                    HStack(spacing: spacing) {
                        // The "0" button spans two columns.
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
                                         backgroundColor: .orange,
                                         normalWidth: normalButtonWidth,
                                         spacing: spacing,
                                         buttonHeight: fixedButtonHeight,
                                         action: viewModel.handleInput)
                    }
                }
                .padding(.bottom)
            }
            // Ensure the calculator fills its parent’s space.
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        // Extend the view under safe area insets if desired.
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Preview

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
