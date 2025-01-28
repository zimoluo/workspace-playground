import SwiftUI

struct WindowView: View {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    @Binding var window: Window
    @ObservedObject var space: Space

    let parentSize: CGSize

    @State private var dragOffset: CGSize = .zero
    @State private var resizeSession: ResizeSession?

    private static let snapDetectDistance: CGFloat = 30
    private static let snapDistance: CGFloat = 12
    private static let snapObstructDistance: CGFloat = 9

    private struct ResizeSession {
        let startDragLocation: CGPoint
        let beginCenterX: CGFloat
        let beginCenterY: CGFloat
        let beginTopLeftX: CGFloat
        let beginTopLeftY: CGFloat
        let startWidth: CGFloat
        let startHeight: CGFloat
    }

    @State private var isCloseButtonActive = false
    @State private var isResizeHandlePressed = false
    @State private var isResizeHandleHovered = false

    private var isResizeHandleActive: Bool {
        isResizeHandleHovered || isResizeHandlePressed
    }

    var body: some View {
        ZStack {
            WindowTypeView(windowData: window.data)
                .frame(width: window.state.width, height: window.state.height)
                .background(LinearGradient(colors: [colorScheme == .light ?theme.secondary.shadeMap(numShades: 26).shadeMap[1].color : theme.secondary.shadeMap(numShades: 40).shadeMap[35].color, colorScheme == .light ? theme.secondary.shadeMap(numShades: 26).shadeMap[0].color : theme.secondary.shadeMap(numShades: 40).shadeMap[33].color], startPoint: .bottom, endPoint: .top))
                .cornerRadius(16)
                .shadow(color: theme.secondary.toShadow(), radius: min(window.state.width, window.state.height)/8.33, y: min(window.state.width, window.state.height)/12.5)
                .environmentObject(space)
                .environment(\.windowId, window.id)

            Group {
                Circle()
                    .fill(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2).opacity(isCloseButtonActive ? 0.75 : 0.6))
                    .frame(width: isCloseButtonActive ? 18 : 12, height: isCloseButtonActive ? 18 : 12)
            }
            .frame(width: 30, height: 30)
            .contentShape(Circle())
            .onHover { hovering in
                withAnimation(.spring(duration: 0.3)) {
                    isCloseButtonActive = hovering
                }
            }
            .onTapGesture {
                withAnimation(.spring(duration: 0.15)) {
                    space.removeWindow(window)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        withAnimation(.spring(duration: 0.3)) {
                            isCloseButtonActive = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.spring(duration: 0.3)) {
                            isCloseButtonActive = false
                        }
                    }
            )
            .offset(
                x: -window.state.width/2 + (isCloseButtonActive ? 9 : 8),
                y: -window.state.height/2 + (isCloseButtonActive ? 9 : 8)
            )

            Group {
                Image("WindowHandle")
                    .resizable()
                    .scaleEffect(isResizeHandleActive ? 1.12 : 1)
                    .frame(width: 27, height: 27)
            }
            .frame(width: 48, height: 48)
            .contentShape(Circle())
            .foregroundStyle(themeColor(from: theme, for: .secondary, in: colorScheme, level: 2).opacity(isResizeHandleActive ? 0.75 : 0.6))
            .onHover { hovering in
                withAnimation(.spring(duration: 0.3)) {
                    isResizeHandleHovered = hovering
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in
                        if window.id != space.windows.last?.id {
                            space.bringToFront(window)
                            return
                        }

                        withAnimation(.spring(duration: 0.3)) {
                            isResizeHandlePressed = true
                        }

                        if resizeSession == nil {
                            let w = window.state.width
                            let h = window.state.height
                            resizeSession = ResizeSession(
                                startDragLocation: value.startLocation,
                                beginCenterX: window.state.x,
                                beginCenterY: window.state.y,
                                beginTopLeftX: window.state.x - w/2,
                                beginTopLeftY: window.state.y - h/2,
                                startWidth: w,
                                startHeight: h
                            )
                        }

                        guard let rs = resizeSession else { return }

                        let deltaX = (value.location.x - rs.startDragLocation.x)/space.cameraZoom
                        let deltaY = (value.location.y - rs.startDragLocation.y)/space.cameraZoom

                        let leftBoundary = space.cameraCenterX - (parentSize.width/2)/space.cameraZoom + 12
                        let rightBoundary = space.cameraCenterX + (parentSize.width/2)/space.cameraZoom - 12
                        let topBoundary = space.cameraCenterY - (parentSize.height/2)/space.cameraZoom + 12
                        let bottomBoundary = space.cameraCenterY + (parentSize.height/2)/space.cameraZoom - 12

                        var isAdaptiveOnX = false
                        var isAdaptiveOnY = false

                        func processDeltasAndGetDimensions(
                            _ rawDx: CGFloat,
                            _ rawDy: CGFloat
                        ) -> (finalDx: CGFloat, finalDy: CGFloat) {
                            var px = rawDx
                            var py = rawDy

                            let factorX: CGFloat = (isAdaptiveOnX ? 1 : 2)
                            let factorY: CGFloat = (isAdaptiveOnY ? 1 : 2)

                            px = px.clamped(to: ((window.data.minWidth - rs.startWidth - (isAdaptiveOnX ? rs.beginTopLeftX - leftBoundary : 0))/factorX) ... ((window.data.maxWidth - rs.startWidth - (isAdaptiveOnX ? rs.beginTopLeftX - leftBoundary : 0))/factorX))

                            py = py.clamped(to: ((window.data.minHeight - rs.startHeight - (isAdaptiveOnY ? rs.beginTopLeftY - topBoundary : 0))/factorY) ... ((window.data.maxHeight - rs.startHeight - (isAdaptiveOnY ? rs.beginTopLeftY - topBoundary : 0))/factorY))

                            let bottomRightX = rs.beginCenterX + rs.startWidth/2 + px
                            let bottomRightY = rs.beginCenterY + rs.startHeight/2 + py

                            if bottomRightX > rightBoundary {
                                px = rightBoundary - rs.beginCenterX - rs.startWidth/2
                            } else if bottomRightX < leftBoundary {
                                px = leftBoundary - rs.beginCenterX - rs.startWidth/2
                            }

                            if bottomRightY > bottomBoundary {
                                py = bottomBoundary - rs.beginCenterY - rs.startHeight/2
                            } else if bottomRightY < topBoundary {
                                py = topBoundary - rs.beginCenterY - rs.startHeight/2
                            }

                            let newWidth = rs.startWidth + px*factorX + (isAdaptiveOnX ? rs.beginTopLeftX - leftBoundary : 0)
                            let newHeight = rs.startHeight + py*factorY + (isAdaptiveOnY ? rs.beginTopLeftY - topBoundary : 0)

                            if newWidth/newHeight > window.data.maxAspectRatio {
                                px = ((newHeight*window.data.maxAspectRatio - rs.startWidth - (isAdaptiveOnX ? rs.beginTopLeftX - leftBoundary : 0))/factorX)

                                if rs.startWidth + px*factorX + (isAdaptiveOnX ? rs.beginTopLeftX - leftBoundary : 0) < window.data.minWidth {
                                    py = ((window.data.minWidth/window.data.maxAspectRatio - rs.startHeight - (isAdaptiveOnY ? rs.beginTopLeftY - topBoundary : 0))/factorY)
                                    px = ((window.data.minWidth - rs.startWidth - (isAdaptiveOnX ? rs.beginTopLeftX - leftBoundary : 0))/factorX)
                                }
                            } else if newWidth/newHeight < window.data.minAspectRatio {
                                py = ((newWidth/window.data.minAspectRatio - rs.startHeight - (isAdaptiveOnY ? rs.beginTopLeftY - topBoundary : 0))/factorY)

                                if rs.startHeight + py*factorY + (isAdaptiveOnY ? rs.beginTopLeftY - topBoundary : 0) < window.data.minHeight {
                                    px = ((window.data.minHeight*window.data.minAspectRatio - rs.startWidth - (isAdaptiveOnX ? rs.beginTopLeftX - leftBoundary : 0))/factorX)
                                    py = ((window.data.minHeight - rs.startHeight - (isAdaptiveOnY ? rs.beginTopLeftY - topBoundary : 0))/factorY)
                                }
                            }

                            return (px, py)
                        }

                        let projection = processDeltasAndGetDimensions(deltaX, deltaY)

                        if rs.beginTopLeftX >= leftBoundary, rs.beginTopLeftX - projection.finalDx < leftBoundary {
                            isAdaptiveOnX = true
                        }

                        if rs.beginTopLeftY >= topBoundary, rs.beginTopLeftY - projection.finalDy < topBoundary {
                            isAdaptiveOnY = true
                        }

                        if isAdaptiveOnX, isAdaptiveOnY {
                            let projectedWidth = rs.startWidth + projection.finalDx + rs.beginTopLeftX - leftBoundary
                            let projectedHeight = rs.startHeight + projection.finalDy + rs.beginTopLeftY - topBoundary

                            let reprojection = processDeltasAndGetDimensions(deltaX, deltaY)
                            let reprojectedWidth = rs.startWidth + reprojection.finalDx + rs.beginTopLeftX - leftBoundary
                            let reprojectedHeight = rs.startHeight + reprojection.finalDy + rs.beginTopLeftY - topBoundary

                            if projectedWidth/projectedHeight > window.data.maxAspectRatio {
                                let widthToCalculate = max(reprojectedHeight*window.data.maxAspectRatio, window.data.minWidth)
                                let newDeltaX = widthToCalculate - rs.startWidth - (rs.beginTopLeftX - leftBoundary)

                                if !(rs.beginTopLeftX - newDeltaX < leftBoundary) {
                                    isAdaptiveOnX = false
                                }

                                if projectedWidth/projectedHeight < window.data.minAspectRatio {
                                    let heightToCalculate = max(reprojectedWidth/window.data.minAspectRatio, window.data.minHeight)
                                    let newDeltaY = heightToCalculate - rs.startHeight - (rs.beginTopLeftY - topBoundary)

                                    if !(rs.beginTopLeftY - newDeltaY < topBoundary) {
                                        isAdaptiveOnY = false
                                    }
                                }
                            }
                        }

                        let finalDimensions = processDeltasAndGetDimensions(deltaX, deltaY)

                        let finalWidth = rs.startWidth +
                            finalDimensions.finalDx*(isAdaptiveOnX ? 1 : 2) +
                            (isAdaptiveOnX ? rs.beginTopLeftX - leftBoundary : 0)

                        let finalHeight = rs.startHeight +
                            finalDimensions.finalDy*(isAdaptiveOnY ? 1 : 2) +
                            (isAdaptiveOnY ? rs.beginTopLeftY - topBoundary : 0)

                        window.state.width = finalWidth
                        window.state.height = finalHeight

                        if isAdaptiveOnX {
                            window.state.x = leftBoundary + finalWidth/2
                        }

                        if isAdaptiveOnY {
                            window.state.y = topBoundary + finalHeight/2
                        }
                    }
                    .onEnded { _ in
                        resizeSession = nil
                        withAnimation(.spring(duration: 0.3)) {
                            isResizeHandlePressed = false
                        }

                        space.updateDateModified()
                    }
            )
            .offset(x: window.state.width/2 - 6, y: window.state.height/2 - 6)
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

                    space.updateDateModified()
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

struct WindowIdKey: EnvironmentKey {
    static let defaultValue: UUID = .init()
}

extension EnvironmentValues {
    var windowId: UUID {
        get { self[WindowIdKey.self] }
        set { self[WindowIdKey.self] = newValue }
    }
}
