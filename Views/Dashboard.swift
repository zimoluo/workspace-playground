import SwiftUI

struct DashboardView: View {
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width
            let fontSize = size < 272 ? size * 0.09 : size * 0.075

            VStack(spacing: 10) {
                AdaptiveFieldContainer(fontSize: fontSize)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(16)
        }
    }
}

struct AdaptiveFieldContainer: View {
    @EnvironmentObject var space: Space
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    let fontSize: CGFloat

    var body: some View {
        GeometryReader { geometry in
            let isNarrow = geometry.size.width < 240

            VStack(spacing: isNarrow ? 0 : 30) {
                if isNarrow {
                    coordinateFields(isNarrow)
                } else {
                    HStack(spacing: 24) {
                        coordinateFields(isNarrow)
                    }
                }
                labeledField(title: "ZOOM", value: "\(String(format: "%.2f", space.cameraZoom))")
            }
            .padding(.vertical, isNarrow ? 16 : 0)
            .frame(maxHeight: .infinity)
        }
    }

    private func coordinateFields(_ isNarrow: Bool) -> some View {
        Group {
            labeledField(
                title: "X",
                value: formatCoordinate(space.cameraCenterX)
            )
            if isNarrow { Spacer() }
            labeledField(
                title: "Y",
                value: formatCoordinate(space.cameraCenterY)
            )
            if isNarrow { Spacer() }
        }
    }

    private func formatCoordinate(_ value: Double) -> String {
        let rounded = Int(value.rounded())
        if abs(rounded) > 9999999 {
            return "VOID"
        }
        return "\(rounded)"
    }

    private func labeledField(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.system(size: fontSize * 0.75, weight: .bold, design: .monospaced))
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
            Text(value)
                .font(.system(size: fontSize, weight: .bold, design: .monospaced))
                .padding(.horizontal, 2)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 1))
                .background(RoundedRectangle(cornerRadius: 16)
                    .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 4)))
                .shadow(color: theme.secondary.toShadow(opacityMultiplier: 0.8), radius: 12, y: 8)
                .lineLimit(1)
        }
    }
}
