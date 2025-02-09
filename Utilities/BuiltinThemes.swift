enum BuiltinThemes {
    static var cherry: Theme {
        return Theme(
            primary: RGBAColor(red: 0.502, green: 0.031, blue: 0.188),
            secondary: RGBAColor(red: 0.769, green: 0.102, blue: 0.525),
            tertiary: RGBAColor(red: 0.812, green: 0.831, blue: 0.773),
            mainGradient: ColorGradient(
                type: .radial,
                stops: [
                    GradientStop(color: RGBAColor(red: 0.812, green: 0.831, blue: 0.773, alpha: 1.0), position: 0.0),
                    GradientStop(color: RGBAColor(red: 0.812, green: 0.831, blue: 0.773, alpha: 1.0), position: 0.2),
                    GradientStop(color: RGBAColor(red: 0.945, green: 0.561, blue: 0.811, alpha: 1.0), position: 0.2001),
                    GradientStop(color: RGBAColor(red: 0.945, green: 0.561, blue: 0.811, alpha: 1.0), position: 0.4),
                    GradientStop(color: RGBAColor(red: 0.937, green: 0.725, blue: 0.796, alpha: 1.0), position: 0.4001),
                    GradientStop(color: RGBAColor(red: 0.937, green: 0.725, blue: 0.796, alpha: 1.0), position: 0.6),
                    GradientStop(color: RGBAColor(red: 0.902, green: 0.678, blue: 0.925, alpha: 1.0), position: 0.6001),
                    GradientStop(color: RGBAColor(red: 0.902, green: 0.678, blue: 0.925, alpha: 1.0), position: 0.8),
                    GradientStop(color: RGBAColor(red: 0.761, green: 0.529, blue: 0.964, alpha: 1.0), position: 0.8001),
                    GradientStop(color: RGBAColor(red: 0.761, green: 0.529, blue: 0.964, alpha: 1.0), position: 1.0)
                ],
                radialAttributes: RadialGradientAttributes(
                    center: CodableUnitPoint(x: 0.5, y: 1.0),
                    edgePoint: CodableUnitPoint(x: 1.0, y: 0.0)
                )
            )
        )
    }

    static var warm: Theme {
        return Theme(
            primary: RGBAColor(red: 0.8901960784313725, green: 0.38823529411764707, blue: 0.3607843137254902),
            secondary: RGBAColor(red: 0.84313725, green: 0.62352941, blue: 0.21176471),
            tertiary: RGBAColor(red: 0.7333333333333333, green: 0.42745098039215684, blue: 0.5294117647058824),
            mainGradient: ColorGradient(
                type: .linear,
                stops: [
                    GradientStop(color: RGBAColor(red: 0.999, green: 0.929, blue: 0.960, alpha: 1.0), position: 0.0),
                    GradientStop(color: RGBAColor(red: 1.025, green: 0.873, blue: 0.694, alpha: 1.0), position: 1.0)
                ],
                linearAttributes: LinearGradientAttributes(
                    startPoint: CodableUnitPoint(x: 0.6666666666666666, y: 1.0),
                    endPoint: CodableUnitPoint(x: 0.3333333333333333, y: 0.0)
                )
            )
        )
    }

    static var cold: Theme {
        return Theme(
            primary: RGBAColor(red: 0.20784313725490197, green: 0.3803921568627451, blue: 0.5411764705882353),
            secondary: RGBAColor(red: 0.43137254901960786, green: 0.6431372549019608, blue: 0.32941176470588235),
            tertiary: RGBAColor(
                red: 0.2627450980392157, green: 0.13333333333333333, blue: 0.4823529411764706
            ),
            mainGradient: ColorGradient(
                type: .angular,
                stops: [
                    GradientStop(color: RGBAColor(red: 0.525, green: 0.310, blue: 0.996, alpha: 1.0), position: 0.0),
                    GradientStop(color: RGBAColor(red: 0.220, green: 0.341, blue: 0.102, alpha: 1.0), position: 1.0)
                ],
                angularAttributes: AngularGradientAttributes(center: CodableUnitPoint(x: 0.5, y: 0.5),
                                                             angle: CodableAngle(from: .degrees(-90)))
            )
        )
    }

    static var whim: Theme {
        return Theme(
            primary: RGBAColor(red: 0.4392156862745098, green: 0.1568627450980392, blue: 0.596078431372549),
            secondary: RGBAColor(red: 0.5529411764705883, green: 0.1803921568627451, blue: 0.30980392156862746),
            tertiary: RGBAColor(red: 0.11372549019607843, green: 0.00784313725490196, blue: 0.5215686274509804),
            mainGradient: ColorGradient(
                type: .mesh,
                stops: [
                    GradientStop(color: RGBAColor(red: 0.525, green: 0.310, blue: 0.996, alpha: 1.0), position: 0.0),
                    GradientStop(color: RGBAColor(red: 0.220, green: 0.341, blue: 0.102, alpha: 1.0), position: 1.0)
                ],
                meshAttributes: MeshGradientAttributes(
                    width: 4,
                    height: 4,
                    points: [
                        [0.0, 0.0],
                        [0.40243998, 0.0],
                        [0.698667, 0.0],
                        [1.0, 0.0],
                        [0.0, 0.33333334],
                        [0.25335205, 0.29464287],
                        [0.4472638, 0.55803573],
                        [1.0, 0.22023809],
                        [0.0, 0.6666667],
                        [0.34202525, 0.7157738],
                        [0.6869738, 0.6964286],
                        [1.0, 0.56994045],
                        [0.0, 1.0],
                        [0.25724977, 1.0],
                        [0.5573745, 1.0],
                        [1.0, 1.0]
                    ],
                    colors: [
                        RGBAColor(red: 0.478, green: 0.129, blue: 0.620, alpha: 1.0),
                        RGBAColor(red: 0.478, green: 0.129, blue: 0.620, alpha: 1.0),
                        RGBAColor(red: 0.600, green: 0.141, blue: 0.310, alpha: 1.0),
                        RGBAColor(red: 0.600, green: 0.141, blue: 0.310, alpha: 1.0),
                        RGBAColor(red: 0.344, green: 0.0, blue: 0.769, alpha: 1.0),
                        RGBAColor(red: 0.472, green: 0.0, blue: 0.470, alpha: 1.0),
                        RGBAColor(red: 0.757, green: 0.0, blue: 0.667, alpha: 1.0),
                        RGBAColor(red: 0.551, green: 0.0, blue: 0.432, alpha: 1.0),
                        RGBAColor(red: 0.0, green: 0.022, blue: 0.627, alpha: 1.0),
                        RGBAColor(red: 0.350, green: 0.0, blue: 0.581, alpha: 1.0),
                        RGBAColor(red: 0.763, green: 0.0, blue: 0.510, alpha: 1.0),
                        RGBAColor(red: 0.714, green: 0.0, blue: 0.645, alpha: 1.0),
                        RGBAColor(red: 0.129, green: 0.0, blue: 0.544, alpha: 1.0),
                        RGBAColor(red: 0.022, green: 0.0, blue: 0.668, alpha: 1.0),
                        RGBAColor(red: 0.0, green: 0.027, blue: 0.518, alpha: 1.0),
                        RGBAColor(red: 0.518, green: 0.0, blue: 0.510, alpha: 1.0)
                    ]
                )
            )
        )
    }
}
