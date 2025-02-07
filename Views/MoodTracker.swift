import simd
import SwiftUI
import UIKit

struct MoodTrackerView: View {
    @State private var moodValue: CGFloat = 0.0

    var baseHue: CGFloat {
        moodHue(for: moodValue)
    }

    var body: some View {
        ZStack {
            AnimatedMeshBackground(baseHue: baseHue)
                .ignoresSafeArea()
            VStack {
                HStack(spacing: 4) {
                    Spacer()
                    Button {
                        print("Something tapped")
                    } label: {
                        Image(systemName: "inset.filled.bottomthird.square")
                            .padding(12)
                            .font(.system(size: 22))
                    }
                    Button {
                        print("Save tapped")
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                            .padding(12)
                            .font(.system(size: 22))
                    }
                }
                Spacer()
                MoodSlider(value: $moodValue)
                    .frame(height: 50)
                    .padding(.horizontal, 40)
            }
        }
    }

    func moodHue(for mood: CGFloat) -> CGFloat {
        let paleBlueHue: CGFloat = 0.55
        let blueHue: CGFloat = 0.60
        let purpleHue: CGFloat = 0.67
        let deepPurpleHue: CGFloat = 0.75
        let lightGreenHue: CGFloat = 0.33
        let lightYellowHue: CGFloat = 0.20
        let orangeYellowHue: CGFloat = 0.10
        if mood < 0 {
            let t = -mood
            if t <= 0.33 {
                return lerp(a: paleBlueHue, b: blueHue, fraction: t / 0.33)
            } else if t <= 0.66 {
                return lerp(a: blueHue, b: purpleHue, fraction: (t - 0.33) / 0.33)
            } else {
                return lerp(a: purpleHue, b: deepPurpleHue, fraction: (t - 0.66) / 0.34)
            }
        } else if mood > 0 {
            let t = mood
            if t <= 0.33 {
                return lerp(a: paleBlueHue, b: lightGreenHue, fraction: t / 0.33)
            } else if t <= 0.66 {
                return lerp(a: lightGreenHue, b: lightYellowHue, fraction: (t - 0.33) / 0.33)
            } else {
                return lerp(a: lightYellowHue, b: orangeYellowHue, fraction: (t - 0.66) / 0.34)
            }
        } else {
            return paleBlueHue
        }
    }

    func lerp(a: CGFloat, b: CGFloat, fraction: CGFloat) -> CGFloat {
        a + (b - a) * fraction
    }
}

struct MoodSlider: View {
    @Binding var value: CGFloat
    @State private var startingValue: CGFloat? = nil

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let thumbSize: CGFloat = 36
            let centerX = width / 2
            let xPos = centerX + value * (width / 2 - thumbSize / 2)
            ZStack {
                Capsule()
                    .fill(Color.black.opacity(0.1))
                    .frame(height: thumbSize)
                Circle()
                    .fill(Color.white)
                    .shadow(radius: 2)
                    .frame(width: thumbSize * 0.8, height: thumbSize * 0.8)
                    .position(x: xPos, y: geometry.size.height / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                if startingValue == nil {
                                    startingValue = value
                                }
                                let range = width / 2 - thumbSize / 2
                                let delta = gesture.translation.width / range
                                value = min(max((startingValue ?? value) + delta, -1), 1)
                            }
                            .onEnded { _ in
                                startingValue = nil
                            }
                    )
            }
        }
        .frame(height: 40)
    }
}

struct MoodTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrackerView()
    }
}
