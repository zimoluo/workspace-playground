//
//  GradientStopEditor.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/13/25.
//


import SwiftUI

struct GradientStopEditor: View {
    @State private var stops: [GradientStop]
    @State private var selectedStopIndex: Int?
    @State private var isDragging = false
    
    init(initialStops: [GradientStop] = [
        GradientStop(color: RGBAColor(red: 0, green: 0, blue: 1, alpha: 1), position: 0),
        GradientStop(color: RGBAColor(red: 1, green: 0, blue: 1, alpha: 1), position: 1)
    ]) {
        _stops = State(initialValue: initialStops)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            // Top bar with position indicator
            HStack {
                Text("At")
                    .foregroundColor(.brown)
                
                Text(String(format: "%.1f", selectedStopIndex.map { stops[$0].position * 100 } ?? 0))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                
                Spacer()
                
                Button(action: {
                    // Add new stop at middle position
                    let newPosition = 0.5
                    let newColor = interpolateColor(position: newPosition)
                    let newStop = GradientStop(color: newColor, position: newPosition)
                    stops.append(newStop)
                    stops.sort { $0.position < $1.position }
                }) {
                    Image(systemName: "plus.square")
                        .font(.title2)
                }
            }
            
            // Gradient bar with stops
            ZStack(alignment: .leading) {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(stops: stops.map { Gradient.Stop(color: $0.color.toColor(), location: $0.position) }),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 12)
                .cornerRadius(6)
                
                // Clickable area for adding new stops
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture { location in
                        let position = location.x
                        let newColor = interpolateColor(position: position)
                        let newStop = GradientStop(color: newColor, position: position)
                        stops.append(newStop)
                        stops.sort { $0.position < $1.position }
                    }
                
                // Stop pins
                ForEach(Array(stops.enumerated()), id: \.element.position) { index, stop in
                    StopPin(
                        isSelected: selectedStopIndex == index,
                        color: stop.color.toColor()
                    )
                    .position(x: stop.position * UIScreen.main.bounds.width, y: 6)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                isDragging = true
                                selectedStopIndex = index
                                
                                // Update stop position
                                let newPosition = max(0, min(1, value.location.x / UIScreen.main.bounds.width))
                                var updatedStops = stops
                                updatedStops[index] = GradientStop(color: stop.color, position: newPosition)
                                updatedStops.sort { $0.position < $1.position }
                                stops = updatedStops
                            }
                            .onEnded { _ in
                                isDragging = false
                            }
                    )
                }
            }
        }
        .padding()
    }
    
    private func interpolateColor(position: Double) -> RGBAColor {
        // Find surrounding stops
        let sortedStops = stops.sorted { $0.position < $1.position }
        guard let firstStop = sortedStops.first,
              let lastStop = sortedStops.last else {
            return RGBAColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        guard let (leftStop, rightStop) = findSurroundingStops(position: position) else {
            if position <= firstStop.position { return firstStop.color }
            if position >= lastStop.position { return lastStop.color }
            return RGBAColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        // Interpolate color
        let t = (position - leftStop.position) / (rightStop.position - leftStop.position)
        return RGBAColor(
            red: leftStop.color.red + (rightStop.color.red - leftStop.color.red) * t,
            green: leftStop.color.green + (rightStop.color.green - leftStop.color.green) * t,
            blue: leftStop.color.blue + (rightStop.color.blue - leftStop.color.blue) * t,
            alpha: leftStop.color.alpha + (rightStop.color.alpha - leftStop.color.alpha) * t
        )
    }
    
    private func findSurroundingStops(position: Double) -> (left: GradientStop, right: GradientStop)? {
        let sortedStops = stops.sorted { $0.position < $1.position }
        for i in 0..<(sortedStops.count - 1) {
            if position >= sortedStops[i].position && position <= sortedStops[i + 1].position {
                return (sortedStops[i], sortedStops[i + 1])
            }
        }
        return nil
    }
}

struct StopPin: View {
    let isSelected: Bool
    let color: Color
    
    var body: some View {
        ZStack {
            // Pin shape
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 12, y: 0))
                path.addLine(to: CGPoint(x: 6, y: 12))
                path.closeSubpath()
            }
            .fill(color)
            .frame(width: 12, height: 12)
            
            // Selection indicator
            if isSelected {
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 4, height: 4)
                    .offset(y: -2)
            }
        }
    }
}

#Preview {
    GradientStopEditor()
}