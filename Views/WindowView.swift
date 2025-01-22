import SwiftUI

struct WindowView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @Binding var window: Window
    @ObservedObject var space: Space

    let parentSize: CGSize

    @State private var dragOffset: CGSize = .zero
    @State private var resizeOffset: CGSize = .zero

    private static let snapDetectDistance: CGFloat = 30
    private static let snapDistance: CGFloat = 12
    private static let snapObstructDistance: CGFloat = 9

    private var adjustedWidth: CGFloat {
        window.state.width + resizeOffset.width * 2
    }

    private var adjustedHeight: CGFloat {
        window.state.height + resizeOffset.height * 2
    }

    var body: some View {
        ZStack {
            WindowTypeView(windowData: window.data)
                .frame(width: adjustedWidth, height: adjustedHeight)
                .background(themeColor(from: theme, for: .secondary, in: colorScheme, level: 5))
                .cornerRadius(16)
                .shadow(color: theme.secondary.toShadow(), radius: adjustedWidth/8.33, y: adjustedWidth/12.5)

            Image("WindowHandle")
                .resizable()
                .frame(width: 27, height: 27)
                .offset(x: adjustedWidth/2 - 6, y: adjustedHeight/2 - 6)
                .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2).opacity(0.6))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if window.id != space.windows.last?.id {
                                space.bringToFront(window)
                            }
                            resizeOffset = value.translation
                        }
                        .onEnded { _ in
                            window.state.width = max(100, adjustedWidth)
                            window.state.height = max(100, adjustedHeight)
                            resizeOffset = .zero
                        }
                )
        }
        .position(x: window.state.x + dragOffset.width, y: window.state.y + dragOffset.height)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if window.id != space.windows.last?.id {
                        space.bringToFront(window)
                    }
                    dragOffset = value.translation
                }
                .onEnded { value in
                    window.state.x += value.translation.width
                    window.state.y += value.translation.height
                    dragOffset = .zero

                    snapToClosestWindow()
                }
        )
        .onTapGesture {
            space.bringToFront(window)
        }
    }

    private func snapToClosestWindow() {
        if space.windows.count < 2 { return }

        let ownRect = boundingRect(for: window)

        let ownLeft = ownRect.minX
        let ownRight = ownRect.maxX
        let ownTop = ownRect.minY
        let ownBottom = ownRect.maxY

        let ownWidth = ownRect.width
        let ownHeight = ownRect.height

        var minDistanceX = WindowView.snapDetectDistance
        var minDistanceY = WindowView.snapDetectDistance

        var desiredX: CGFloat? = nil
        var desiredY: CGFloat? = nil

        var beforeShoulderMinDistanceX = minDistanceX
        var beforeShoulderMinDistanceY = minDistanceY

        let sortedWindows = space.windows.enumerated()
            .filter { $0.element.id != window.id }
            .sorted { lhs, rhs in
                lhs.offset > rhs.offset
            }

        for (idx, otherWin) in sortedWindows {
            let otherRect = boundingRect(for: otherWin)

            let verticalOverlap = rectsVerticallyOverlap(
                ownTop: ownTop,
                ownBottom: ownBottom,
                otherTop: otherRect.minY,
                otherBottom: otherRect.maxY
            )

            if verticalOverlap {
                let distanceLeft = abs(ownLeft - otherRect.maxX)
                let distanceRight = abs(ownRight - otherRect.minX)

                let sidesToCheck: [(distance: CGFloat,
                                    oppositeDistance: CGFloat,
                                    sideCondition: Bool,
                                    desiredXCalc: () -> CGFloat,
                                    areaForObstruction: () -> CGRect,
                                    areaForShoulderTop: (CGFloat) -> CGRect,
                                    areaForShoulderBottom: (CGFloat) -> CGRect,
                                    otherTop: CGFloat,
                                    otherBottom: CGFloat)] = [
                    (
                        distance: distanceLeft,
                        oppositeDistance: distanceRight,
                        sideCondition: ownRight > otherRect.minX,
                        desiredXCalc: { otherRect.maxX + WindowView.snapDistance + ownWidth/2 },
                        areaForObstruction: {
                            let leftEdge = otherRect.maxX - WindowView.snapObstructDistance
                            let rightEdge = otherRect.maxX + WindowView.snapObstructDistance
                            let topEdge = max(ownTop, otherRect.minY) - WindowView.snapObstructDistance
                            let bottomEdge = min(ownBottom, otherRect.maxY) + WindowView.snapObstructDistance
                            return CGRect(x: leftEdge,
                                          y: topEdge,
                                          width: rightEdge - leftEdge,
                                          height: bottomEdge - topEdge)
                        },
                        areaForShoulderTop: { newX in
                            let xLeft = (newX - ownWidth/2) - WindowView.snapObstructDistance
                            let xRight = (newX + ownWidth/2) + WindowView.snapObstructDistance
                            let yTop = otherRect.minY - WindowView.snapObstructDistance
                            let yBottom = otherRect.minY + WindowView.snapObstructDistance
                            return CGRect(x: xLeft,
                                          y: yTop,
                                          width: xRight - xLeft,
                                          height: yBottom - yTop)
                        },
                        areaForShoulderBottom: { newX in
                            let xLeft = (newX - ownWidth/2) - WindowView.snapObstructDistance
                            let xRight = (newX + ownWidth/2) + WindowView.snapObstructDistance
                            let yTop = otherRect.maxY - WindowView.snapObstructDistance
                            let yBottom = otherRect.maxY + WindowView.snapObstructDistance
                            return CGRect(x: xLeft,
                                          y: yTop,
                                          width: xRight - xLeft,
                                          height: yBottom - yTop)
                        },
                        otherTop: otherRect.minY,
                        otherBottom: otherRect.maxY
                    ),
                    (
                        distance: distanceRight,
                        oppositeDistance: distanceLeft,
                        sideCondition: ownLeft < otherRect.maxX,
                        desiredXCalc: { otherRect.minX - WindowView.snapDistance - ownWidth/2 },
                        areaForObstruction: {
                            let leftEdge = otherRect.minX - WindowView.snapObstructDistance
                            let rightEdge = otherRect.minX + WindowView.snapObstructDistance
                            let topEdge = max(ownTop, otherRect.minY) - WindowView.snapObstructDistance
                            let bottomEdge = min(ownBottom, otherRect.maxY) + WindowView.snapObstructDistance
                            return CGRect(x: leftEdge,
                                          y: topEdge,
                                          width: rightEdge - leftEdge,
                                          height: bottomEdge - topEdge)
                        },
                        areaForShoulderTop: { newX in
                            let xLeft = (newX - ownWidth/2) - WindowView.snapObstructDistance
                            let xRight = (newX + ownWidth/2) + WindowView.snapObstructDistance
                            let yTop = otherRect.minY - WindowView.snapObstructDistance
                            let yBottom = otherRect.minY + WindowView.snapObstructDistance
                            return CGRect(x: xLeft,
                                          y: yTop,
                                          width: xRight - xLeft,
                                          height: yBottom - yTop)
                        },
                        areaForShoulderBottom: { newX in
                            let xLeft = (newX - ownWidth/2) - WindowView.snapObstructDistance
                            let xRight = (newX + ownWidth/2) + WindowView.snapObstructDistance
                            let yTop = otherRect.maxY - WindowView.snapObstructDistance
                            let yBottom = otherRect.maxY + WindowView.snapObstructDistance
                            return CGRect(x: xLeft,
                                          y: yTop,
                                          width: xRight - xLeft,
                                          height: yBottom - yTop)
                        },
                        otherTop: otherRect.minY,
                        otherBottom: otherRect.maxY
                    )
                ]

                for side in sidesToCheck {
                    let distance = side.distance
                    if distance <= WindowView.snapDetectDistance &&
                        distance <= side.oppositeDistance &&
                        distance <= minDistanceX &&
                        side.sideCondition
                    {
                        let area = side.areaForObstruction()
                        if isUnobstructed(area: area,
                                          candidateIndex: idx)
                        {
                            let snapCenterX = side.desiredXCalc()
                            desiredX = snapCenterX
                            minDistanceX = distance
                            beforeShoulderMinDistanceX = minDistanceX

                            minDistanceY = beforeShoulderMinDistanceY

                            let topDistance = abs(ownTop - side.otherTop)
                            let bottomDistance = abs(ownBottom - side.otherBottom)

                            if topDistance <= WindowView.snapDetectDistance &&
                                topDistance <= bottomDistance &&
                                topDistance <= minDistanceY
                            {
                                let shoulderArea = side.areaForShoulderTop(snapCenterX)
                                if isUnobstructed(area: shoulderArea,
                                                  candidateIndex: idx)
                                {
                                    desiredY = side.otherTop + ownHeight/2
                                    beforeShoulderMinDistanceY = minDistanceY
                                    minDistanceY = topDistance
                                }
                            } else if bottomDistance <= WindowView.snapDetectDistance &&
                                bottomDistance <= topDistance &&
                                bottomDistance <= minDistanceY
                            {
                                let shoulderArea = side.areaForShoulderBottom(snapCenterX)
                                if isUnobstructed(area: shoulderArea,
                                                  candidateIndex: idx)
                                {
                                    desiredY = side.otherBottom - ownHeight/2
                                    beforeShoulderMinDistanceY = minDistanceY
                                    minDistanceY = bottomDistance
                                }
                            }
                        }
                    }
                }
            }

            let horizontalOverlap = rectsHorizontallyOverlap(
                ownLeft: ownLeft,
                ownRight: ownRight,
                otherLeft: otherRect.minX,
                otherRight: otherRect.maxX
            )

            if horizontalOverlap {
                let distanceTop = abs(ownTop - otherRect.maxY)
                let distanceBottom = abs(ownBottom - otherRect.minY)

                let sidesToCheck: [(distance: CGFloat,
                                    oppositeDistance: CGFloat,
                                    sideCondition: Bool,
                                    desiredYCalc: () -> CGFloat,
                                    areaForObstruction: () -> CGRect,
                                    areaForShoulderLeft: (CGFloat) -> CGRect,
                                    areaForShoulderRight: (CGFloat) -> CGRect,
                                    otherLeft: CGFloat,
                                    otherRight: CGFloat)] = [
                    (
                        distance: distanceTop,
                        oppositeDistance: distanceBottom,
                        sideCondition: ownBottom > otherRect.minY,
                        desiredYCalc: { otherRect.maxY + WindowView.snapDistance + ownHeight/2 },
                        areaForObstruction: {
                            let topEdge = otherRect.maxY - WindowView.snapObstructDistance
                            let bottomEdge = otherRect.maxY + WindowView.snapObstructDistance
                            let leftEdge = max(ownLeft, otherRect.minX) - WindowView.snapObstructDistance
                            let rightEdge = min(ownRight, otherRect.maxX) + WindowView.snapObstructDistance
                            return CGRect(x: leftEdge,
                                          y: topEdge,
                                          width: rightEdge - leftEdge,
                                          height: bottomEdge - topEdge)
                        },
                        areaForShoulderLeft: { newY in
                            let yTop = (newY - ownHeight/2) - WindowView.snapObstructDistance
                            let yBottom = (newY + ownHeight/2) + WindowView.snapObstructDistance
                            let xLeft = otherRect.minX - WindowView.snapObstructDistance
                            let xRight = otherRect.minX + WindowView.snapObstructDistance
                            return CGRect(x: xLeft,
                                          y: yTop,
                                          width: xRight - xLeft,
                                          height: yBottom - yTop)
                        },
                        areaForShoulderRight: { newY in
                            let yTop = (newY - ownHeight/2) - WindowView.snapObstructDistance
                            let yBottom = (newY + ownHeight/2) + WindowView.snapObstructDistance
                            let xLeft = otherRect.maxX - WindowView.snapObstructDistance
                            let xRight = otherRect.maxX + WindowView.snapObstructDistance
                            return CGRect(x: xLeft,
                                          y: yTop,
                                          width: xRight - xLeft,
                                          height: yBottom - yTop)
                        },
                        otherLeft: otherRect.minX,
                        otherRight: otherRect.maxX
                    ),
                    (
                        distance: distanceBottom,
                        oppositeDistance: distanceTop,
                        sideCondition: ownTop < otherRect.maxY,
                        desiredYCalc: { otherRect.minY - WindowView.snapDistance - ownHeight/2 },
                        areaForObstruction: {
                            let topEdge = otherRect.minY - WindowView.snapObstructDistance
                            let bottomEdge = otherRect.minY + WindowView.snapObstructDistance
                            let leftEdge = max(ownLeft, otherRect.minX) - WindowView.snapObstructDistance
                            let rightEdge = min(ownRight, otherRect.maxX) + WindowView.snapObstructDistance
                            return CGRect(x: leftEdge,
                                          y: topEdge,
                                          width: rightEdge - leftEdge,
                                          height: bottomEdge - topEdge)
                        },
                        areaForShoulderLeft: { newY in
                            let yTop = (newY - ownHeight/2) - WindowView.snapObstructDistance
                            let yBottom = (newY + ownHeight/2) + WindowView.snapObstructDistance
                            let xLeft = otherRect.minX - WindowView.snapObstructDistance
                            let xRight = otherRect.minX + WindowView.snapObstructDistance
                            return CGRect(x: xLeft,
                                          y: yTop,
                                          width: xRight - xLeft,
                                          height: yBottom - yTop)
                        },
                        areaForShoulderRight: { newY in
                            let yTop = (newY - ownHeight/2) - WindowView.snapObstructDistance
                            let yBottom = (newY + ownHeight/2) + WindowView.snapObstructDistance
                            let xLeft = otherRect.maxX - WindowView.snapObstructDistance
                            let xRight = otherRect.maxX + WindowView.snapObstructDistance
                            return CGRect(x: xLeft,
                                          y: yTop,
                                          width: xRight - xLeft,
                                          height: yBottom - yTop)
                        },
                        otherLeft: otherRect.minX,
                        otherRight: otherRect.maxX
                    )
                ]

                for side in sidesToCheck {
                    let distance = side.distance
                    if distance <= WindowView.snapDetectDistance &&
                        distance <= side.oppositeDistance &&
                        distance <= minDistanceY &&
                        side.sideCondition
                    {
                        let area = side.areaForObstruction()
                        if isUnobstructed(area: area,
                                          candidateIndex: idx)
                        {
                            let snapCenterY = side.desiredYCalc()
                            desiredY = snapCenterY
                            minDistanceY = distance
                            beforeShoulderMinDistanceY = minDistanceY

                            minDistanceX = beforeShoulderMinDistanceX

                            let leftDistance = abs(ownLeft - side.otherLeft)
                            let rightDistance = abs(ownRight - side.otherRight)

                            if leftDistance <= WindowView.snapDetectDistance &&
                                leftDistance <= rightDistance &&
                                leftDistance <= minDistanceX
                            {
                                let shoulderArea = side.areaForShoulderLeft(snapCenterY)
                                if isUnobstructed(area: shoulderArea,
                                                  candidateIndex: idx)
                                {
                                    desiredX = side.otherLeft + ownWidth/2
                                    beforeShoulderMinDistanceX = minDistanceX
                                    minDistanceX = leftDistance
                                }
                            } else if rightDistance <= WindowView.snapDetectDistance &&
                                rightDistance <= leftDistance &&
                                rightDistance <= minDistanceX
                            {
                                let shoulderArea = side.areaForShoulderRight(snapCenterY)
                                if isUnobstructed(area: shoulderArea,
                                                  candidateIndex: idx)
                                {
                                    desiredX = side.otherRight - ownWidth/2
                                    beforeShoulderMinDistanceX = minDistanceX
                                    minDistanceX = rightDistance
                                }
                            }
                        }
                    }
                }
            }
        }

        guard desiredX != nil || desiredY != nil else { return }

        withAnimation(.spring(duration: 0.3)) {
            if let x = desiredX {
                window.state.x = x
            }
            if let y = desiredY {
                window.state.y = y
            }
        }
    }

    private func isUnobstructed(area: CGRect, candidateIndex: Int) -> Bool {
        if space.windows.count < 3 { return true }

        let candidateWin = space.windows[candidateIndex]

        guard let candidateRealIndex = space.windows.firstIndex(where: { $0.id == candidateWin.id }) else {
            return true
        }

        let candidateAboveIndex = candidateRealIndex
        for topIndex in (candidateAboveIndex + 1) ..< space.windows.count {
            let topWin = space.windows[topIndex]
            if topWin.id == window.id { continue }

            let topRect = boundingRect(for: topWin)
            if topRect.minX <= area.minX &&
                topRect.maxX >= area.maxX &&
                topRect.minY <= area.minY &&
                topRect.maxY >= area.maxY
            {
                return false
            }
        }

        return true
    }

    private func boundingRect(for w: Window) -> CGRect {
        let centerX = w.state.x
        let centerY = w.state.y
        let width = w.state.width
        let height = w.state.height

        return CGRect(
            x: centerX - width/2,
            y: centerY - height/2,
            width: width,
            height: height
        )
    }

    private func rectsVerticallyOverlap(ownTop: CGFloat,
                                        ownBottom: CGFloat,
                                        otherTop: CGFloat,
                                        otherBottom: CGFloat) -> Bool
    {
        return max(0, min(ownBottom, otherBottom) - max(ownTop, otherTop)) > 0
    }

    private func rectsHorizontallyOverlap(ownLeft: CGFloat,
                                          ownRight: CGFloat,
                                          otherLeft: CGFloat,
                                          otherRight: CGFloat) -> Bool
    {
        return max(0, min(ownRight, otherRight) - max(ownLeft, otherLeft)) > 0
    }
}
