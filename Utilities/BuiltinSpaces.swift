import SwiftUI

enum BuiltinSpaces {
    static var doodle: Space {
        return Space(
            windows: [
                Window(
                    state: WindowState(x: 0, y: 0, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -112, y: -112, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 112, y: -112, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -224, y: -224, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -336, y: -224, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 224, y: -224, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 336, y: -224, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 448, y: -112, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 560, y: 0, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 560, y: 112, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 448, y: 224, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 336, y: 336, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 224, y: 448, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 112, y: 560, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 0, y: 672, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -112, y: 560, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -224, y: 448, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -336, y: 336, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -448, y: 224, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -560, y: 112, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -560, y: 0, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -448, y: -112, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1912.3333333333335, y: -2317.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1912.3333333333335, y: -2205.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -2024.3333333333335, y: -2317.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1800.3333333333335, y: -2317.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1393.3333333333335, y: -2775.8333333333335, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1505.3333333333335, y: -2720.6666666666665, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1569.666666666667, y: -2608.6666666666665, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1569.666666666667, y: -2496.6666666666665, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1342.3333333333335, y: -2663.8333333333335, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1342.3333333333335, y: -2551.8333333333335, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -1534, y: -2384.6666666666665, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -1476, y: -2272.6666666666665, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -1280, y: -2439.8333333333335, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -1364, y: -2214.6666666666665, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -1168, y: -2393.3333333333335, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -1252, y: -2168.6666666666665, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -1140, y: -2168.6666666666665, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -1028, y: -2220.6666666666674, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -1056, y: -2360.6666666666665, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1912.3333333333335, y: -2429.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -944, y: -2332.6666666666674, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1827.4999999999998, y: -2684.333333333333, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1827.4999999999998, y: -2796.333333333333, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1939.4999999999998, y: -2796.333333333333, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1715.4999999999998, y: -2796.333333333333, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1827.4999999999998, y: -2908.333333333333, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -966.0000000000001, y: -2691.833333333333, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -854.0000000000001, y: -2691.833333333333, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -1078, y: -2691.833333333333, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -966.0000000000001, y: -2579.833333333333, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -966.0000000000001, y: -2803.833333333333, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -802.8333333333337, y: -2061, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -914.8333333333337, y: -2061, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -802.8333333333337, y: -2173, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -690.8333333333337, y: -2061, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -802.8333333333337, y: -1949, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1436.1666666666665, y: -1899.6666666666667, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1436.1666666666665, y: -2011.6666666666667, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1548.1666666666665, y: -1899.666666666667, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1324.1666666666665, y: -1899.6666666666667, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1436.1666666666665, y: -1787.6666666666667, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1355.8333333333335, y: -3073.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1243.8333333333335, y: -3073.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1243.8333333333335, y: -2961.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1131.8333333333335, y: -3073.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -1243.8333333333335, y: -3185.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3302.333333333333, y: -2001.0000000000002, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3190.333333333333, y: -2001, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3078.333333333333, y: -2001, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3414.333333333333, y: -2001, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2966.333333333333, y: -2001, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3526.333333333333, y: -2001, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3638.333333333333, y: -2001, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3750.333333333333, y: -2113, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3862.333333333333, y: -2225, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3862.333333333333, y: -2337, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3862.333333333333, y: -2449, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2854.333333333333, y: -2113, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2742.333333333333, y: -2225, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2742.333333333333, y: -2337, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2742.333333333333, y: -2449, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2854.333333333333, y: -2561, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2966.333333333333, y: -2673, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2966.333333333333, y: -2785, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2854.333333333333, y: -2785, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2742.333333333333, y: -2785, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2742.333333333333, y: -2897, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2854.333333333333, y: -2897, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2630.333333333333, y: -2897, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2854.333333333333, y: -3009, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2854.333333333333, y: -3121, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2966.333333333333, y: -3233, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3078.333333333333, y: -3233, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3190.333333333333, y: -3233, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3302.333333333333, y: -3233, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3078.333333333333, y: -3009, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3414.333333333333, y: -3121, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3414.333333333333, y: -3009, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3414.333333333333, y: -2897, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3302.333333333333, y: -2785, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3190.333333333333, y: -2673, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3414.333333333333, y: -2673, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3526.333333333333, y: -2673, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3638.333333333333, y: -2673, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3862.333333333333, y: -2561, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3862.333333333333, y: -2673, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3750.333333333333, y: -2561, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3638.333333333333, y: -2449, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3302.333333333333, y: -2561, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3526.333333333333, y: -2337, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3414.333333333333, y: -2337, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3302.333333333333, y: -2337, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3190.333333333333, y: -2449, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2862.166666666667, y: 3253.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2974.166666666667, y: 3253.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2750.166666666667, y: 3365.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2750.166666666667, y: 3477.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2638.166666666667, y: 3477.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2862.166666666667, y: 3477.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2974.166666666667, y: 3477.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3086.166666666667, y: 3477.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3198.166666666667, y: 3589.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3310.166666666667, y: 3589.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3422.166666666667, y: 3701.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3422.166666666667, y: 3813.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3534.166666666667, y: 3925.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3534.166666666667, y: 4037.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3534.166666666667, y: 4150, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3534.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3422.166666666667, y: 4374, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3422.166666666667, y: 4486, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3310.166666666667, y: 4598, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3198.166666666667, y: 4598, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3086.166666666667, y: 4598, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2974.166666666667, y: 4598, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2862.166666666667, y: 4598, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2526.166666666667, y: 3477.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2414.166666666667, y: 3589.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2302.166666666667, y: 3589.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2190.166666666667, y: 3701.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2190.166666666667, y: 3813.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2078.166666666667, y: 3925.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2078.166666666667, y: 4037.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2078.166666666667, y: 4150, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2078.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2190.166666666667, y: 4374, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2190.166666666667, y: 4486, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2302.166666666667, y: 4598, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2414.166666666667, y: 4598, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2526.166666666667, y: 4598, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2638.166666666667, y: 4598, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2750.166666666667, y: 4598, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2414.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2414.166666666667, y: 4374, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2302.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2302.166666666667, y: 4150, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2526.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2526.166666666667, y: 4150, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2638.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2638.166666666667, y: 4150, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2638.166666666667, y: 4374, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2750.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2750.166666666667, y: 4374, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2862.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2862.166666666667, y: 4374, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2862.166666666667, y: 4150, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2974.166666666667, y: 4374, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2974.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2974.166666666667, y: 4150, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3086.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3086.166666666667, y: 4150, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3198.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3198.166666666667, y: 4374, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3310.166666666667, y: 4262, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 3310.166666666667, y: 4150, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2414.166666666667, y: 3701.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2414.166666666667, y: 3813.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2526.166666666667, y: 3813.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2638.166666666667, y: 3813.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3198.166666666667, y: 3701.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3198.166666666667, y: 3813.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 3086.166666666667, y: 3813.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 2974.166666666667, y: 3813.9999999999995, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: -2072.833333333333, y: 4689.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["animatedMeshBackgroundSalt": "2015584093", "hue": "0.5"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -2234.833333333333, y: 4689.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["hue": "0.3", "animatedMeshBackgroundSalt": "1146112960"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -2072.833333333333, y: 4527.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["hue": "0.7", "animatedMeshBackgroundSalt": "945311832"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -1910.833333333333, y: 4689.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["hue": "0.7", "animatedMeshBackgroundSalt": "482449168"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -2072.833333333333, y: 4851.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["animatedMeshBackgroundSalt": "476140867", "hue": "0.3"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -2234.833333333333, y: 4527.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["animatedMeshBackgroundSalt": "716183793", "hue": "0.3"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -1910.833333333333, y: 4527.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["hue": "0.7", "animatedMeshBackgroundSalt": "1680385908"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -2234.833333333333, y: 4851.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["animatedMeshBackgroundSalt": "952946280", "hue": "0.3"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -1910.833333333333, y: 4851.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["animatedMeshBackgroundSalt": "1749038742", "hue": "0.7"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -2396.833333333333, y: 4689.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["animatedMeshBackgroundSalt": "408590993", "hue": "0.1"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -2072.833333333333, y: 4365.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["hue": "0.9", "animatedMeshBackgroundSalt": "1851703604"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -1748.833333333333, y: 4689.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["animatedMeshBackgroundSalt": "1777040533", "hue": "0.9"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -2072.833333333333, y: 5013.166666666667, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: ["animatedMeshBackgroundSalt": "993101823", "hue": "0.1"],
                        minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
            ],
            name: "Doodle 🎨",
            cameraCenterX: 3084,
            cameraCenterY: -2796,
            cameraZoom: 0.75,
            showMarkers: true,
            markers: [
                SpaceMarker(x: 2829.5, y: 3759.5, zoom: 0.75),
                SpaceMarker(x: -2072.833333333333, y: 4689.166666666667, zoom: 0.85),
                SpaceMarker(x: -1244.5, y: -2332.5, zoom: 0.75),
                SpaceMarker(x: 0, y: 225.5, zoom: 0.75), SpaceMarker(x: 3084, y: -2796, zoom: 0.75),
            ],
            disableDots: true,
            lockCamera: false,
            disableOrganizeWindows: true)
    }
    
    static var personal: Space {
        return Space(
            windows: [
                Window(
                    state: WindowState(x: -189.5, y: 18.5, width: 300, height: 320),
                    data: WindowData(
                        type: .habitTracker, saveData: [:], minHeight: 260, minWidth: 280,
                        maxHeight: 600, maxWidth: 450, minAspectRatio: 0,
                        maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: 132.5, y: -74.5, width: 320, height: 134),
                    data: WindowData(
                        type: .image, saveData: [:], minHeight: 134, minWidth: 320, maxHeight: 320,
                        maxWidth: 320, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 136.5, y: -449.5, width: 228, height: 108),
                    data: WindowData(
                        type: .themePicker, saveData: [:], minHeight: 108, minWidth: 228,
                        maxHeight: 160, maxWidth: 228, minAspectRatio: 0,
                        maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: -491.5, y: -309, width: 280, height: 200),
                    data: WindowData(
                        type: .quote, saveData: [:], minHeight: 160, minWidth: 160, maxHeight: 440,
                        maxWidth: 440, minAspectRatio: 0.8, maxAspectRatio: 1.55, layer: 0), false),
                Window(
                    state: WindowState(x: 47.5, y: 79.5, width: 150, height: 150),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: [
                            "hue": "0.8891473961000697", "animatedMeshBackgroundSalt": "1102382279",
                        ], minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(x: -461.5, y: -57, width: 220, height: 280),
                    data: WindowData(
                        type: .notes,
                        saveData: [
                            "richTextEditorKey":
                                "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGvEBoLDBMXHy0uLzAxOT4/U1RaYmNNZGVobHGBhlUkbnVsbNMNDg8QERJYTlNTdHJpbmdWJGNsYXNzXE5TQXR0cmlidXRlc4ACgBmABNIOFBUWWU5TLnN0cmluZ4ADbxARAEEAIABmAHIAZQBzAGgAIABuAGUAdwAgAGQAYQB5ACAnKNIYGRobWiRjbGFzc25hbWVYJGNsYXNzZXNfEA9OU011dGFibGVTdHJpbmejHB0eXxAPTlNNdXRhYmxlU3RyaW5nWE5TU3RyaW5nWE5TT2JqZWN00yAhDiInLFdOUy5rZXlzWk5TLm9iamVjdHOkIyQlJoAFgAaAB4AIpCgpKiuACYALgAyAF4AUXxAQTlNQYXJhZ3JhcGhTdHlsZV8QEmlzRGVmYXVsdFRleHRDb2xvclZOU0ZvbnRXTlNDb2xvctQyMzQONTY3OFpOU1RhYlN0b3BzXxASTlNXcml0aW5nRGlyZWN0aW9uW05TQWxpZ25tZW50gAAQARAEgArSGBk6O18QF05TTXV0YWJsZVBhcmFncmFwaFN0eWxlozw9Hl8QF05TTXV0YWJsZVBhcmFncmFwaFN0eWxlXxAQTlNQYXJhZ3JhcGhTdHlsZQnbQEFCQ0QORUZHSElKSktMTU5PTTVMPl8QIlVJRm9udE1heGltdW1Qb2ludFNpemVBZnRlclNjYWxpbmdfEBlVSUZvbnRQb2ludFNpemVGb3JTY2FsaW5nXxAQVUlGb250RGVzY3JpcHRvclZOU05hbWVWTlNTaXplXFVJRm9udFRyYWl0c18QD1VJRm9udFBvaW50U2l6ZV8QGVVJRm9udFRleHRTdHlsZUZvclNjYWxpbmdaVUlGb250TmFtZVxVSVN5c3RlbUZvbnQjAAAAAAAAAACADoANI0A0AAAAAAAAgBYQAIAAgA0JXS5TRlVJLVJlZ3VsYXLTVQ5WV1hZXxAXVUlGb250RGVzY3JpcHRvck9wdGlvbnNfEBpVSUZvbnREZXNjcmlwdG9yQXR0cmlidXRlcxKAAIQEgBWAD9MgIQ5bXiyiXF2AEIARol9ggBKAE4AUXxATTlNGb250U2l6ZUF0dHJpYnV0ZV8QGE5TQ1RGb250VUlVc2FnZUF0dHJpYnV0ZV8QEkNURm9udFJlZ3VsYXJVc2FnZdIYGWZnXE5TRGljdGlvbmFyeaJmHtIYGWlqXxAQVUlGb250RGVzY3JpcHRvcqJrHl8QEFVJRm9udERlc2NyaXB0b3LTGBltbm9wWyRjbGFzc2hpbnRzVlVJRm9udKJuHqEv2HJzdHV2Dnd4eXp7fH1+f4BfEBVVSUNvbG9yQ29tcG9uZW50Q291bnRXVUlHcmVlblZVSUJsdWVXVUlBbHBoYVVOU1JHQlVVSVJlZFxOU0NvbG9yU3BhY2UQBCI+E6MoIj6EOqEiP4AAAE8QETAuNDczIDAuMTQ0IDAuMjU4gBgiPvH4PhAC0xgZbYKDhFdVSUNvbG9yooIeoYVXTlNDb2xvctIYGYeIXxAZTlNNdXRhYmxlQXR0cmlidXRlZFN0cmluZ6OJih5fEBlOU011dGFibGVBdHRyaWJ1dGVkU3RyaW5nXxASTlNBdHRyaWJ1dGVkU3RyaW5nAAgAEQAaACQAKQAyADcASQBMAFEAUwBwAHYAfQCGAI0AmgCcAJ4AoAClAK8AsQDWANsA5gDvAQEBBQEXASABKQEwATgBQwFIAUoBTAFOAVABVQFXAVkBWwFdAV8BcgGHAY4BlgGfAaoBvwHLAc0BzwHRAdMB2AHyAfYCEAIjAiQCOwJgAnwCjwKWAp0CqgK8AtgC4wLwAvkC+wL9AwYDCAMKAwwDDgMPAx0DJAM+A1sDYANiA2QDawNuA3ADcgN1A3cDeQN7A5EDrAPBA8YD0wPWA9sD7gPxBAQECwQXBB4EIQQjBDQETARUBFsEYwRpBG8EfAR+BIMEiASNBKEEowSoBKoEsQS5BLwEvgTGBMsE5wTrBQcAAAAAAAACAQAAAAAAAACLAAAAAAAAAAAAAAAAAAAFHA==",
                        ], minHeight: 200, minWidth: 200, maxHeight: 800, maxWidth: 800,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: -164.5, y: -343.5, width: 350, height: 380),
                    data: WindowData(
                        type: .importantDays, saveData: ["viewState": #"{"list":[]}"#],
                        minHeight: 380, minWidth: 350, maxHeight: 420, maxWidth: 440,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: -472.8525491562421, y: -496, width: 242.70509831248424, height: 150),
                    data: WindowData(
                        type: .clock, saveData: [:],
                        minHeight: 150, minWidth: 150, maxHeight: 450, maxWidth: 450,
                        minAspectRatio: 0.6180339887498949, maxAspectRatio: 1.618033988749895, layer: 0), false),
                Window(
                    state: WindowState(x: 212.5, y: -268.5, width: 380, height: 230),
                    data: WindowData(
                        type: .countdownTimer,
                        saveData: [
                            "eventName": "WWDC 2025", "selectedDate": "2025-06-09T17:00:00Z",
                            "targetDate": "2025-06-09T17:00:00Z",
                        ], minHeight: 230, minWidth: 380, maxHeight: 280, maxWidth: 420,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: 1816.5, y: -323.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 1928.5, y: -211.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2040.5, y: -323.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 1704.5, y: -435.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2152.5, y: -435.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 1592.5, y: -547.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2264.5, y: -547.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2376.5, y: -659.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 1480.5, y: -659.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 1480.5, y: -771.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 1592.5, y: -883.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 1704.5, y: -883.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 1816.5, y: -771.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2376.5, y: -771.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2264.5, y: -883.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2152.5, y: -883.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 2040.5, y: -771.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: 1928.5, y: -659.5, width: 100, height: 100),
                    data: WindowData(
                        type: .blank, saveData: [:], minHeight: 100, minWidth: 100, maxHeight: 800,
                        maxWidth: 800, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(
                        x: 1939.902957188126, y: 115.09821748649642, width: 350.0476059077114,
                        height: 200),
                    data: WindowData(
                        type: .notes,
                        saveData: [
                            "richTextEditorKey":
                                "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGvEBoLDBMXHy0uLzAxOT5OVGdobnZ3Ynh5fIBmhVUkbnVsbNMNDg8QERJYTlNTdHJpbmdWJGNsYXNzXE5TQXR0cmlidXRlc4ACgBmABNIOFBUWWU5TLnN0cmluZ4ADXxAeVGhhbmsgeW91IGZvciB1c2luZyBXb3JrU3BhY2Uh0hgZGhtaJGNsYXNzbmFtZVgkY2xhc3Nlc18QD05TTXV0YWJsZVN0cmluZ6McHR5fEA9OU011dGFibGVTdHJpbmdYTlNTdHJpbmdYTlNPYmplY3TTICEOIicsV05TLmtleXNaTlMub2JqZWN0c6QjJCUmgAWABoAHgAikKCkqK4AJgAuADYAYgBVfEBBOU1BhcmFncmFwaFN0eWxlV05TQ29sb3JWTlNGb250XxASaXNEZWZhdWx0VGV4dENvbG9y1DIzNA41Njc4Wk5TVGFiU3RvcHNfEBJOU1dyaXRpbmdEaXJlY3Rpb25bTlNBbGlnbm1lbnSAABABEASACtIYGTo7XxAXTlNNdXRhYmxlUGFyYWdyYXBoU3R5bGWjPD0eXxAXTlNNdXRhYmxlUGFyYWdyYXBoU3R5bGVfEBBOU1BhcmFncmFwaFN0eWxl2D9AQUJDDkRFRkdISUpLTE1fEBVVSUNvbG9yQ29tcG9uZW50Q291bnRXVUlHcmVlblZVSUJsdWVXVUlBbHBoYVVOU1JHQlVVSVJlZFxOU0NvbG9yU3BhY2UQBCI+E6MoIj6EOqEiP4AAAE8QETAuNDczIDAuMTQ0IDAuMjU4gAwiPvH4PhAC0xgZT1BRUlskY2xhc3NoaW50c1dVSUNvbG9yolAeoVNXTlNDb2xvcttVVldYWQ5aW1xdXl9fYGFiY01iNWFmXxAiVUlGb250TWF4aW11bVBvaW50U2l6ZUFmdGVyU2NhbGluZ18QGVVJRm9udFBvaW50U2l6ZUZvclNjYWxpbmdfEBBVSUZvbnREZXNjcmlwdG9yVk5TTmFtZVZOU1NpemVcVUlGb250VHJhaXRzXxAPVUlGb250UG9pbnRTaXplXxAZVUlGb250VGV4dFN0eWxlRm9yU2NhbGluZ1pVSUZvbnROYW1lXFVJU3lzdGVtRm9udCMAAAAAAAAAAIAPgA4jQDQAAAAAAACAF4AAgA4JXi5TRlVJLVNlbWlib2xk02kOamtsbV8QF1VJRm9udERlc2NyaXB0b3JPcHRpb25zXxAaVUlGb250RGVzY3JpcHRvckF0dHJpYnV0ZXMSgACEBIAWgBDTICEOb3IsonBxgBGAEqJzdIATgBSAFV8QE05TRm9udFNpemVBdHRyaWJ1dGVfEBhOU0NURm9udFVJVXNhZ2VBdHRyaWJ1dGVfEBVDVEZvbnRFbXBoYXNpemVkVXNhZ2XSGBl6e1xOU0RpY3Rpb25hcnmieh7SGBl9fl8QEFVJRm9udERlc2NyaXB0b3Kifx5fEBBVSUZvbnREZXNjcmlwdG9y0xgZT4GCg1ZVSUZvbnSigR6hLwnSGBmGh18QGU5TTXV0YWJsZUF0dHJpYnV0ZWRTdHJpbmejiIkeXxAZTlNNdXRhYmxlQXR0cmlidXRlZFN0cmluZ18QEk5TQXR0cmlidXRlZFN0cmluZwAIABEAGgAkACkAMgA3AEkATABRAFMAcAB2AH0AhgCNAJoAnACeAKAApQCvALEA0gDXAOIA6wD9AQEBEwEcASUBLAE0AT8BRAFGAUgBSgFMAVEBUwFVAVcBWQFbAW4BdgF9AZIBmwGmAbsBxwHJAcsBzQHPAdQB7gHyAgwCHwIwAkgCUAJXAl8CZQJrAngCegJ/AoQCiQKdAp8CpAKmAq0CuQLBAsQCxgLOAuUDCgMmAzkDQANHA1QDZgOCA40DmgOjA6UDpwOwA7IDtAO2A7cDxgPNA+cEBAQJBAsEDQQUBBcEGQQbBB4EIAQiBCQEOgRVBG0EcgR/BIIEhwSaBJ0EsAS3BL4EwQTDBMQEyQTlBOkFBQAAAAAAAAIBAAAAAAAAAIoAAAAAAAAAAAAAAAAAAAUa",
                        ], minHeight: 200, minWidth: 200, maxHeight: 800, maxWidth: 800,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
            ],
            name: "Lifestyle 🍎",
            cameraCenterX: -105,
            cameraCenterY: -183.5,
            cameraZoom: 0.9,
            showMarkers: false,
            markers: [
                SpaceMarker(x: 1928, y: -540.5, zoom: 0.9),
                SpaceMarker(x: -105, y: -183.5, zoom: 0.9),
            ],
            disableDots: false,
            lockCamera: false,
            disableOrganizeWindows: true)
    }
    
    static var productivity: Space {
        return Space(
            windows: [
                Window(
                    state: WindowState(x: 152.5, y: 4.5, width: 200, height: 360),
                    data: WindowData(
                        type: .calculator,
                        saveData: [
                            "CalculatorData":
                                #"{"tokens":[],"currentDisplay":"500","currentInput":"500","previousExpression":"20×25"}"#,
                        ], minHeight: 360, minWidth: 200, maxHeight: 360, maxWidth: 360,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: -118, y: 142, width: 317, height: 311),
                    data: WindowData(
                        type: .toDoList,
                        saveData: [
                            "items": #"[{"id":""# + UUID().uuidString
                                + #"","title":"Workout 🏃"},{"id":""# + UUID().uuidString
                                + #"","title":"Read for one hour 📚"},{"id":""# + UUID().uuidString
                                + #"","title":"Calculate 20 × 25"}]"#, "listTitle": "Today 💪",
                        ], minHeight: 260, minWidth: 180, maxHeight: 600, maxWidth: 400,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: -285.5, y: -551.5, width: 336, height: 293),
                    data: WindowData(
                        type: .habitTracker, saveData: [:], minHeight: 260, minWidth: 280,
                        maxHeight: 600, maxWidth: 450, minAspectRatio: 0,
                        maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: -0.5, y: -593, width: 210, height: 210),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: [
                            "hue": "0.9517950868878532", "animatedMeshBackgroundSalt": "2060772169",
                        ], minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(x: 192.5, y: 296.5, width: 280, height: 200),
                    data: WindowData(
                        type: .quote, saveData: [:], minHeight: 160, minWidth: 160, maxHeight: 440,
                        maxWidth: 440, minAspectRatio: 0.8, maxAspectRatio: 1.55, layer: 0), false),
                Window(
                    state: WindowState(x: -119.5, y: 376.5, width: 320, height: 134),
                    data: WindowData(
                        type: .image, saveData: [:], minHeight: 134, minWidth: 320, maxHeight: 320,
                        maxWidth: 320, minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0),
                    false),
                Window(
                    state: WindowState(x: -79.5, y: -100.5, width: 240, height: 150),
                    data: WindowData(
                        type: .digitalClock, saveData: [:], minHeight: 120, minWidth: 120,
                        maxHeight: 420, maxWidth: 420, minAspectRatio: 1, maxAspectRatio: 2,
                        layer: 0), false),
                Window(
                    state: WindowState(x: 15, y: 886.5, width: 320, height: 220),
                    data: WindowData(
                        type: .pomodoroTimer, saveData: [:], minHeight: 220, minWidth: 298,
                        maxHeight: 280, maxWidth: 440, minAspectRatio: 0,
                        maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: 1021, y: 17.5, width: 380, height: 230),
                    data: WindowData(
                        type: .countdownTimer,
                        saveData: [
                            "eventName": "WWDC 2025", "selectedDate": "2025-06-09T18:15:04Z",
                            "targetDate": "2025-06-09T13:00:00Z",
                        ], minHeight: 230, minWidth: 380, maxHeight: 280, maxWidth: 420,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: 1021, y: 334.5, width: 380, height: 380),
                    data: WindowData(
                        type: .importantDays,
                        saveData: [
                            "viewState": #"{"list":[]}"#, "newDayDate": "2022-06-06T18:14:18Z",
                            "newDayName": "",
                        ], minHeight: 380, minWidth: 350, maxHeight: 420, maxWidth: 440,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: 337, y: 956.5, width: 300, height: 360),
                    data: WindowData(
                        type: .stopwatch, saveData: [:], minHeight: 340, minWidth: 280,
                        maxHeight: 600, maxWidth: 420, minAspectRatio: 0,
                        maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: -172.5, y: 1108.5, width: 291, height: 200),
                    data: WindowData(
                        type: .notes,
                        saveData: [
                            "richTextEditorKey":
                                "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGvEBoLDBMXHy0uLzAxOT4/U1RaYmNNZGVobHGBhlUkbnVsbNMNDg8QERJYTlNTdHJpbmdWJGNsYXNzXE5TQXR0cmlidXRlc4ACgBmABNIOFBUWWU5TLnN0cmluZ4ADbxAZAEcAbwB0AHQAYQAgAHIAdQBuACAAYQBoAGUAYQBkACAAbwBmACAAdABpAG0AZQAgI/DSGBkaG1okY2xhc3NuYW1lWCRjbGFzc2VzXxAPTlNNdXRhYmxlU3RyaW5noxwdHl8QD05TTXV0YWJsZVN0cmluZ1hOU1N0cmluZ1hOU09iamVjdNMgIQ4iJyxXTlMua2V5c1pOUy5vYmplY3RzpCMkJSaABYAGgAeACKQoKSorgAmAC4AMgBeAFF8QEE5TUGFyYWdyYXBoU3R5bGVfEBJpc0RlZmF1bHRUZXh0Q29sb3JWTlNGb250V05TQ29sb3LUMjM0DjU2NzhaTlNUYWJTdG9wc18QEk5TV3JpdGluZ0RpcmVjdGlvbltOU0FsaWdubWVudIAAEAEQBIAK0hgZOjtfEBdOU011dGFibGVQYXJhZ3JhcGhTdHlsZaM8PR5fEBdOU011dGFibGVQYXJhZ3JhcGhTdHlsZV8QEE5TUGFyYWdyYXBoU3R5bGUJ20BBQkNEDkVGR0hJSkpLTE1OT001TD5fECJVSUZvbnRNYXhpbXVtUG9pbnRTaXplQWZ0ZXJTY2FsaW5nXxAZVUlGb250UG9pbnRTaXplRm9yU2NhbGluZ18QEFVJRm9udERlc2NyaXB0b3JWTlNOYW1lVk5TU2l6ZVxVSUZvbnRUcmFpdHNfEA9VSUZvbnRQb2ludFNpemVfEBlVSUZvbnRUZXh0U3R5bGVGb3JTY2FsaW5nWlVJRm9udE5hbWVcVUlTeXN0ZW1Gb250IwAAAAAAAAAAgA6ADSNANAAAAAAAAIAWEACAAIANCV0uU0ZVSS1SZWd1bGFy01UOVldYWV8QF1VJRm9udERlc2NyaXB0b3JPcHRpb25zXxAaVUlGb250RGVzY3JpcHRvckF0dHJpYnV0ZXMSgACEBIAVgA/TICEOW14solxdgBCAEaJfYIASgBOAFF8QE05TRm9udFNpemVBdHRyaWJ1dGVfEBhOU0NURm9udFVJVXNhZ2VBdHRyaWJ1dGVfEBJDVEZvbnRSZWd1bGFyVXNhZ2XSGBlmZ1xOU0RpY3Rpb25hcnmiZh7SGBlpal8QEFVJRm9udERlc2NyaXB0b3Kiax5fEBBVSUZvbnREZXNjcmlwdG9y0xgZbW5vcFskY2xhc3NoaW50c1ZVSUZvbnSibh6hL9hyc3R1dg53eHl6e3x9fn+AXxAVVUlDb2xvckNvbXBvbmVudENvdW50V1VJR3JlZW5WVUlCbHVlV1VJQWxwaGFVTlNSR0JVVUlSZWRcTlNDb2xvclNwYWNlEAQiPhOjKCI+hDqhIj+AAABPEBEwLjQ3MyAwLjE0NCAwLjI1OIAYIj7x+D4QAtMYGW2Cg4RXVUlDb2xvcqKCHqGFV05TQ29sb3LSGBmHiF8QGU5TTXV0YWJsZUF0dHJpYnV0ZWRTdHJpbmejiYoeXxAZTlNNdXRhYmxlQXR0cmlidXRlZFN0cmluZ18QEk5TQXR0cmlidXRlZFN0cmluZwAIABEAGgAkACkAMgA3AEkATABRAFMAcAB2AH0AhgCNAJoAnACeAKAApQCvALEA5gDrAPYA/wERARUBJwEwATkBQAFIAVMBWAFaAVwBXgFgAWUBZwFpAWsBbQFvAYIBlwGeAaYBrwG6Ac8B2wHdAd8B4QHjAegCAgIGAiACMwI0AksCcAKMAp8CpgKtAroCzALoAvMDAAMJAwsDDQMWAxgDGgMcAx4DHwMtAzQDTgNrA3ADcgN0A3sDfgOAA4IDhQOHA4kDiwOhA7wD0QPWA+MD5gPrA/4EAQQUBBsEJwQuBDEEMwREBFwEZARrBHMEeQR/BIwEjgSTBJgEnQSxBLMEuAS6BMEEyQTMBM4E1gTbBPcE+wUXAAAAAAAAAgEAAAAAAAAAiwAAAAAAAAAAAAAAAAAABSw=",
                        ], minHeight: 200, minWidth: 200, maxHeight: 800, maxWidth: 800,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: 80, y: 1103.5, width: 190, height: 190),
                    data: WindowData(
                        type: .clock, saveData: [:], minHeight: 150, minWidth: 150, maxHeight: 450,
                        maxWidth: 450, minAspectRatio: 0.6180339887498949,
                        maxAspectRatio: 1.618033988749895, layer: 0), false),
                Window(
                    state: WindowState(x: -1744, y: 60.5, width: 250, height: 320),
                    data: WindowData(
                        type: .dashboard, saveData: [:], minHeight: 300, minWidth: 200,
                        maxHeight: 330, maxWidth: 400, minAspectRatio: 0,
                        maxAspectRatio: 1000000000, layer: 0), false),
            ],
            name: "Productivity ⏳",
            cameraCenterX: 57.5,
            cameraCenterY: 123.5,
            cameraZoom: 1.0,
            showMarkers: false,
            markers: [
                SpaceMarker(x: 87, y: 984, zoom: 1), SpaceMarker(x: -130.5, y: -544.5, zoom: 1),
                SpaceMarker(x: 57.5, y: 123.5, zoom: 1),
            ],
            disableDots: false,
            lockCamera: false,
            disableOrganizeWindows: false)
    }
    
    static var writing: Space {
        return Space(
            windows: [
                Window(
                    state: WindowState(x: -342, y: -69.5, width: 150, height: 242.7050983124842),
                    data: WindowData(
                        type: .clock, saveData: [:], minHeight: 150, minWidth: 150, maxHeight: 450,
                        maxWidth: 450, minAspectRatio: 0.6180339887498949,
                        maxAspectRatio: 1.618033988749895, layer: 0), false),
                Window(
                    state: WindowState(x: -54.5, y: -30.852549156242105, width: 401, height: 320),
                    data: WindowData(
                        type: .notes,
                        saveData: [
                            "richTextEditorKey":
                                "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGvECsLDBUZISc0NTY3OEBFRlpbYWlqVGtsb3N4iI2bnJ2mqbGyuLm6vsHHzNDVVSRudWxs1A0ODxAREhMUWE5TU3RyaW5nXxAPTlNBdHRyaWJ1dGVJbmZvXE5TQXR0cmlidXRlc1YkY2xhc3OAAoAogASAKtIQFhcYWU5TLnN0cmluZ4ADbxAZAEgAbwB3ACAAcwBoAG8AdQBsAGQAIABJACAAcgBlAHMAcABvAG4AZCAmACD//AAKAArSGhscHVokY2xhc3NuYW1lWCRjbGFzc2VzXxAPTlNNdXRhYmxlU3RyaW5nox4fIF8QD05TTXV0YWJsZVN0cmluZ1hOU1N0cmluZ1hOU09iamVjdNIiECMmWk5TLm9iamVjdHOiJCWABYAagCfTKCIQKS4zV05TLmtleXOkKissLYAGgAeACIAJpC8wMTKACoAMgA2AGIAVXxAQTlNQYXJhZ3JhcGhTdHlsZV8QEmlzRGVmYXVsdFRleHRDb2xvclZOU0ZvbnRXTlNDb2xvctQ5OjsQPD0+P1pOU1RhYlN0b3BzXxASTlNXcml0aW5nRGlyZWN0aW9uW05TQWxpZ25tZW50gAAQARAEgAvSGhtBQl8QF05TTXV0YWJsZVBhcmFncmFwaFN0eWxlo0NEIF8QF05TTXV0YWJsZVBhcmFncmFwaFN0eWxlXxAQTlNQYXJhZ3JhcGhTdHlsZQnbR0hJSksQTE1OT1BRUVJTVFVWVDxTRV8QIlVJRm9udE1heGltdW1Qb2ludFNpemVBZnRlclNjYWxpbmdfEBlVSUZvbnRQb2ludFNpemVGb3JTY2FsaW5nXxAQVUlGb250RGVzY3JpcHRvclZOU05hbWVWTlNTaXplXFVJRm9udFRyYWl0c18QD1VJRm9udFBvaW50U2l6ZV8QGVVJRm9udFRleHRTdHlsZUZvclNjYWxpbmdaVUlGb250TmFtZVxVSVN5c3RlbUZvbnQjAAAAAAAAAACAD4AOI0A0AAAAAAAAgBcQAIAAgA4JXS5TRlVJLVJlZ3VsYXLTXBBdXl9gXxAXVUlGb250RGVzY3JpcHRvck9wdGlvbnNfEBpVSUZvbnREZXNjcmlwdG9yQXR0cmlidXRlcxKAAIQEgBaAENMoIhBiZTOiY2SAEYASomZngBOAFIAVXxATTlNGb250U2l6ZUF0dHJpYnV0ZV8QGE5TQ1RGb250VUlVc2FnZUF0dHJpYnV0ZV8QEkNURm9udFJlZ3VsYXJVc2FnZdIaG21uXE5TRGljdGlvbmFyeaJtINIaG3BxXxAQVUlGb250RGVzY3JpcHRvcqJyIF8QEFVJRm9udERlc2NyaXB0b3LTGht0dXZ3WyRjbGFzc2hpbnRzVlVJRm9udKJ1IKE22Hl6e3x9EH5/gIGCg4SFhodfEBVVSUNvbG9yQ29tcG9uZW50Q291bnRXVUlHcmVlblZVSUJsdWVXVUlBbHBoYVVOU1JHQlVVSVJlZFxOU0NvbG9yU3BhY2UQBCI+E6MoIj6EOqEiP4AAAE8QETAuNDczIDAuMTQ0IDAuMjU4gBkiPvH4PhAC0xobdImKi1dVSUNvbG9yookgoYxXTlNDb2xvctMoIhCOlDOlLJCRKi2ACIAbgByABoAJpZUwl5iZgB2ADIAhgCWAJoAVXxASaXNEZWZhdWx0VGV4dENvbG9yXxAXQ1RBZGFwdGl2ZUltYWdlUHJvdmlkZXLbR0hJSksQTE1OT1BRUZ5ToFVWojxTRYAegA4jQEhdLLGx5M2AFyNASF0ssbHkzYAAgA4J01wQXV5fqIAWgB/TKCIQqq0zomNkgBGAEqKuZ4AggBSAFSNASF0ssbHkzdOztBC1trdfEBROUy5jb250ZW50SWRlbnRpZmllcl8QD05TLmltYWdlQ29udGVudIAigCOAJF8QJTVDQUExMjVGLTc2NDMtNDUxMC05MkU4LTYzQThCQjcwOEY5NjBPEbWEAAAAJGZ0eXBoZWljAAAAAG1pZjFNaUhFbWlhZk1pSEJoZWljAAAKLW1ldGEAAAAAAAAAIWhkbHIAAAAAAAAAAHBpY3QAAAAAAAAAAAAAAAAAAAAAJGRpbmYAAAAcZHJlZgAAAAAAAAABAAAADHVybCAAAAABAAAADnBpdG0AAAAAAAEAAAIWaWluZgAAAAAAFAAAABVpbmZlAgAAAAABAABodmMxAAAAABVpbmZlAgAAAQACAABodmMxAAAAABVpbmZlAgAAAQADAABFeGlmAAAAAClpbmZlAgAAAQAEAABtaW1l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ME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDYuMC4wIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxuczpJcHRjNHhtcEV4dD0iaHR0cDovL2lwdGMub3JnL3N0ZC9JcHRjNHhtcEV4dC8yMDA4LTAyLTI5LyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHBob3Rvc2hvcDpDcmVkaXQ9IkFwcGxlIEltYWdlIFBsYXlncm91bmQiIElwdGM0eG1wRXh0OkRpZ2l0YWxTb3VyY2VUeXBlPSJodHRwOi8vY3YuaXB0Yy5vcmcvbmV3c2NvZGVzL2RpZ2l0YWxzb3VyY2V0eXBlL3RyYWluZWRBbGdvcml0aG1pY01lZGlhIiB4bXA6Q3JlYXRvclRvb2w9IkFwcGxlIFRleHRLaXQiPiA8ZGM6ZGVzY3JpcHRpb24+IDxyZGY6QWx0PiA8cmRmOmxpIHhtbDpsYW5nPSJ4LWRlZmF1bHQiPlJhaW5ib3cgdGhpbmtpbmcgZmFjZTwvcmRmOmxpPiA8L3JkZjpBbHQ+IDwvZGM6ZGVzY3JpcHRpb24+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDw/eHBhY2tldCBlbmQ9InciPz4AAAAABkV4aWYAAE1NACoAAAAIAAYBDQACAAAAJgAAAFYBDgACAAAAFgAAAHwBHgAFAAAAAQAAAJIBHwAFAAAAAQAAAJoBMQACAAAADgAAAKKHaQAEAAAAAQAAALAAAAAANUNBQTEyNUYtNzY0My00NTEwLTkyRTgtNjNBOEJCNzA4Rjk2MABSYWluYm93IHRoaW5raW5nIGZhY2UAAAAAAAAAAAEAAAAAAAAAAUFwcGxlIFRleHRLaXQAAAGkIAACAAAAJgAAAMIAAAAANUNBQTEyNUYtNzY0My00NTEwLTkyRTgtNjNBOEJCNzA4Rjk2MAA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJYTVAgQ29yZSA2LjAuMCI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6SXB0YzR4bXBFeHQ9Imh0dHA6Ly9pcHRjLm9yZy9zdGQvSXB0YzR4bXBFeHQvMjAwOC0wMi0yOS8iIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiBwaG90b3Nob3A6Q3JlZGl0PSJBcHBsZSBJbWFnZSBQbGF5Z3JvdW5kIiBJcHRjNHhtcEV4dDpEaWdpdGFsU291cmNlVHlwZT0iaHR0cDovL2N2LmlwdGMub3JnL25ld3Njb2Rlcy9kaWdpdGFsc291cmNldHlwZS90cmFpbmVkQWxnb3JpdGhtaWNNZWRpYSIgeG1wOkNyZWF0b3JUb29sPSJBcHBsZSBUZXh0S2l0Ij4gPGRjOmRlc2NyaXB0aW9uPiA8cmRmOkFsdD4gPHJkZjpsaSB4bWw6bGFuZz0ieC1kZWZhdWx0Ij5SYWluYm93IHRoaW5raW5nIGZhY2U8L3JkZjpsaT4gPC9yZGY6QWx0PiA8L2RjOmRlc2NyaXB0aW9uPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8P3hwYWNrZXQgZW5kPSJ3Ij8+AAAAAAZFeGlmAABNTQAqAAAACAAGAQ0AAgAAACYAAABWAQ4AAgAAABYAAAB8AR4ABQAAAAEAAACSAR8ABQAAAAEAAACaATEAAgAAAA4AAACih2kABAAAAAEAAACwAAAAADVDQUExMjVGLTc2NDMtNDUxMC05MkU4LTYzQThCQjcwOEY5NjAAUmFpbmJvdyB0aGlua2luZyBmYWNlAAAAAAAAAAABAAAAAAAAAAFBcHBsZSBUZXh0S2l0AAABpCAAAgAAACYAAADCAAAAADVDQUExMjVGLTc2NDMtNDUxMC05MkU4LTYzQThCQjcwOEY5NjAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNi4wLjAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOklwdGM0eG1wRXh0PSJodHRwOi8vaXB0Yy5vcmcvc3RkL0lwdGM0eG1wRXh0LzIwMDgtMDItMjkvIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgcGhvdG9zaG9wOkNyZWRpdD0iQXBwbGUgSW1hZ2UgUGxheWdyb3VuZCIgSXB0YzR4bXBFeHQ6RGlnaXRhbFNvdXJjZVR5cGU9Imh0dHA6Ly9jdi5pcHRjLm9yZy9uZXdzY29kZXMvZGlnaXRhbHNvdXJjZXR5cGUvdHJhaW5lZEFsZ29yaXRobWljTWVkaWEiIHhtcDpDcmVhdG9yVG9vbD0iQXBwbGUgVGV4dEtpdCI+IDxkYzpkZXNjcmlwdGlvbj4gPHJkZjpBbHQ+IDxyZGY6bGkgeG1sOmxhbmc9IngtZGVmYXVsdCI+UmFpbmJvdyB0aGlua2luZyBmYWNlPC9yZGY6bGk+IDwvcmRmOkFsdD4gPC9kYzpkZXNjcmlwdGlvbj4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPD94cGFja2V0IGVuZD0idyI/PgAAAAAGRXhpZgAATU0AKgAAAAgABgENAAIAAAAmAAAAVgEOAAIAAAAWAAAAfAEeAAUAAAABAAAAkgEfAAUAAAABAAAAmgExAAIAAAAOAAAAoodpAAQAAAABAAAAsAAAAAA1Q0FBMTI1Ri03NjQzLTQ1MTAtOTJFOC02M0E4QkI3MDhGOTYwAFJhaW5ib3cgdGhpbmtpbmcgZmFjZQAAAAAAAAAAAQAAAAAAAAABQXBwbGUgVGV4dEtpdAAAAaQgAAIAAAAmAAAAwgAAAAA1Q0FBMTI1Ri03NjQzLTQ1MTAtOTJFOC02M0E4QkI3MDhGOTYwADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDYuMC4wIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxuczpJcHRjNHhtcEV4dD0iaHR0cDovL2lwdGMub3JnL3N0ZC9JcHRjNHhtcEV4dC8yMDA4LTAyLTI5LyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHBob3Rvc2hvcDpDcmVkaXQ9IkFwcGxlIEltYWdlIFBsYXlncm91bmQiIElwdGM0eG1wRXh0OkRpZ2l0YWxTb3VyY2VUeXBlPSJodHRwOi8vY3YuaXB0Yy5vcmcvbmV3c2NvZGVzL2RpZ2l0YWxzb3VyY2V0eXBlL3RyYWluZWRBbGdvcml0aG1pY01lZGlhIiB4bXA6Q3JlYXRvclRvb2w9IkFwcGxlIFRleHRLaXQiPiA8ZGM6ZGVzY3JpcHRpb24+IDxyZGY6QWx0PiA8cmRmOmxpIHhtbDpsYW5nPSJ4LWRlZmF1bHQiPlJhaW5ib3cgdGhpbmtpbmcgZmFjZTwvcmRmOmxpPiA8L3JkZjpBbHQ+IDwvZGM6ZGVzY3JpcHRpb24+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDw/eHBhY2tldCBlbmQ9InciPz4AAAAABkV4aWYAAE1NACoAAAAIAAYBDQACAAAAJgAAAFYBDgACAAAAFgAAAHwBHgAFAAAAAQAAAJIBHwAFAAAAAQAAAJoBMQACAAAADgAAAKKHaQAEAAAAAQAAALAAAAAANUNBQTEyNUYtNzY0My00NTEwLTkyRTgtNjNBOEJCNzA4Rjk2MABSYWluYm93IHRoaW5raW5nIGZhY2UAAAAAAAAAAAEAAAAAAAAAAUFwcGxlIFRleHRLaXQAAAGkIAACAAAAJgAAAMIAAAAANUNBQTEyNUYtNzY0My00NTEwLTkyRTgtNjNBOEJCNzA4Rjk2MAA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJYTVAgQ29yZSA2LjAuMCI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6SXB0YzR4bXBFeHQ9Imh0dHA6Ly9pcHRjLm9yZy9zdGQvSXB0YzR4bXBFeHQvMjAwOC0wMi0yOS8iIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiBwaG90b3Nob3A6Q3JlZGl0PSJBcHBsZSBJbWFnZSBQbGF5Z3JvdW5kIiBJcHRjNHhtcEV4dDpEaWdpdGFsU291cmNlVHlwZT0iaHR0cDovL2N2LmlwdGMub3JnL25ld3Njb2Rlcy9kaWdpdGFsc291cmNldHlwZS90cmFpbmVkQWxnb3JpdGhtaWNNZWRpYSIgeG1wOkNyZWF0b3JUb29sPSJBcHBsZSBUZXh0S2l0Ij4gPGRjOmRlc2NyaXB0aW9uPiA8cmRmOkFsdD4gPHJkZjpsaSB4bWw6bGFuZz0ieC1kZWZhdWx0Ij5SYWluYm93IHRoaW5raW5nIGZhY2U8L3JkZjpsaT4gPC9yZGY6QWx0PiA8L2RjOmRlc2NyaXB0aW9uPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8P3hwYWNrZXQgZW5kPSJ3Ij8+AAAAFWcoAa+UXN+hbpYkwCtnfSf+IStv3t9L3sDVprt+336nFHAyQDp5QCweAlg4y2Sct4zje+Y3KTC4ptwXTJM1F4pAVeo3ve5AONp9vAXvZZBIuei6lpsbMyIRssIx679u0RooQYXJuBhGGHp4kg45lE667gkqpQQLFUGVOZgeJT7AHaUGjnE1X0MZOXU8sn477k714YgCi2Y7Fe3UOL09IqisrFPyLh5J11Ly+tEQC+4GF4AArfTwEEJFlT4mhOfCE3Gjc+wAr3nnw6IfwX4PBngBaLxvL2CoewxCO3/Ad2yqVUzZmHaFL3ivb9r+f0PNLH4bg28aK4HwaoN1CL8OBWoRhTpDYuyL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",
                        ], minHeight: 200, minWidth: 200, maxHeight: 800, maxWidth: 800,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: -216.5, y: -282.8525491562421, width: 264, height: 160),
                    data: WindowData(
                        type: .writingPrompt, saveData: [:], minHeight: 160, minWidth: 160,
                        maxHeight: 440, maxWidth: 440, minAspectRatio: 0.8, maxAspectRatio: 1.65,
                        layer: 0), false),
                Window(
                    state: WindowState(x: 87.5, y: -312.8525491562421, width: 320, height: 220),
                    data: WindowData(
                        type: .pomodoroTimer, saveData: [:], minHeight: 220, minWidth: 298,
                        maxHeight: 280, maxWidth: 440, minAspectRatio: 0,
                        maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: 264.7297893706013, y: -686, width: 210, height: 210),
                    data: WindowData(
                        type: .magicGlobe,
                        saveData: [
                            "animatedMeshBackgroundSalt": "1058763631", "hue": "0.7294111587880858",
                        ], minHeight: 150, minWidth: 150, maxHeight: 500, maxWidth: 500,
                        minAspectRatio: 0.8333, maxAspectRatio: 1.2, layer: 0), false),
                Window(
                    state: WindowState(x: 129.14095648390247, y: -973, width: 420, height: 340),
                    data: WindowData(
                        type: .stopwatch,
                        saveData: [
                            "stopwatchState": #"{"startDate":"#
                                + "\(Double(Date().addingTimeInterval(-3 * 60 * 60).timeIntervalSinceReferenceDate).description)"
                                + #","accumulatedTime":0,"state":"running","laps":[]}"#,
                        ], minHeight: 340, minWidth: 280, maxHeight: 600, maxWidth: 420,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -277.62781414598317, y: 432.5369974257455, width: 357.06169657066744,
                        height: 289.99960926638926),
                    data: WindowData(
                        type: .toDoList,
                        saveData: [
                            "items": #"[{"id":""# + UUID().uuidString
                                + #"","title":"Respond to today’s prompt"},{"id":""#
                                + UUID().uuidString + #"","title":"Finish my reading"}]"#,
                            "listTitle": "My Tasks 📝",
                        ], minHeight: 260, minWidth: 180, maxHeight: 600, maxWidth: 400,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -299.59911964297925, y: 643.5368020589401, width: 228, height: 108),
                    data: WindowData(
                        type: .themePicker, saveData: [:], minHeight: 108, minWidth: 228,
                        maxHeight: 160, maxWidth: 228, minAspectRatio: 0,
                        maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(
                        x: 102.90303413935055, y: 462.5368020589401, width: 380, height: 230),
                    data: WindowData(
                        type: .countdownTimer,
                        saveData: [
                            "selectedDate": "2025-02-13T18:51:57Z",
                            "targetDate": ISO8601DateFormatter().string(
                                from: Calendar.current.date(
                                    bySettingHour: 9, minute: 0, second: 0,
                                    of: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)!.addingTimeInterval(
                                    -TimeInterval(TimeZone.current.secondsFromGMT()))),
                            "eventName": "Tomorrow!",
                        ], minHeight: 230, minWidth: 380, maxHeight: 280, maxWidth: 420,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(
                        x: -2854.1348538608054, y: -167.7836601293447, width: 352.87184206699226,
                        height: 200),
                    data: WindowData(
                        type: .notes,
                        saveData: [
                            "richTextEditorKey":
                                "YnBsaXN0MDDUAQIDBAUGBwpYJHZlcnNpb25ZJGFyY2hpdmVyVCR0b3BYJG9iamVjdHMSAAGGoF8QD05TS2V5ZWRBcmNoaXZlctEICVRyb290gAGvEBoLDBMXHy0uLzAxNzw9UlNZYWJjZGVobHGAhVUkbnVsbNMNDg8QERJYTlNTdHJpbmdWJGNsYXNzXE5TQXR0cmlidXRlc4ACgBmABNIOFBUWWU5TLnN0cmluZ4ADXllvdSBmb3VuZCBtZSEh0hgZGhtaJGNsYXNzbmFtZVgkY2xhc3Nlc18QD05TTXV0YWJsZVN0cmluZ6McHR5fEA9OU011dGFibGVTdHJpbmdYTlNTdHJpbmdYTlNPYmplY3TTICEOIicsV05TLmtleXNaTlMub2JqZWN0c6QjJCUmgAWABoAHgAikKCkqK4AJgAuADIAXgBRfEBBOU1BhcmFncmFwaFN0eWxlXxASaXNEZWZhdWx0VGV4dENvbG9yVk5TRm9udFdOU0NvbG9y0zIOMzQ1Nl8QEk5TV3JpdGluZ0RpcmVjdGlvblpOU1RhYlN0b3BzEAGACoAA0hgZODlfEBdOU011dGFibGVQYXJhZ3JhcGhTdHlsZaM6Ox5fEBdOU011dGFibGVQYXJhZ3JhcGhTdHlsZV8QEE5TUGFyYWdyYXBoU3R5bGUJ2z4/QEFCDkNERUZHSEhJSktMTU42SjxfECJVSUZvbnRNYXhpbXVtUG9pbnRTaXplQWZ0ZXJTY2FsaW5nXxAZVUlGb250UG9pbnRTaXplRm9yU2NhbGluZ18QEFVJRm9udERlc2NyaXB0b3JWTlNOYW1lVk5TU2l6ZVxVSUZvbnRUcmFpdHNfEA9VSUZvbnRQb2ludFNpemVfEBlVSUZvbnRUZXh0U3R5bGVGb3JTY2FsaW5nWlVJRm9udE5hbWVcVUlTeXN0ZW1Gb250IwAAAAAAAAAAgA6ADSNAQhs8nGiA8oAWEAIjQEIbPJxogPKAAIANCV4uU0ZVSS1TZW1pYm9sZNNUDlVWV1hfEBdVSUZvbnREZXNjcmlwdG9yT3B0aW9uc18QGlVJRm9udERlc2NyaXB0b3JBdHRyaWJ1dGVzEoAAhASAFYAP0yAhDlpdLKJbXIAQgBGiXl+AEoATgBRfEBNOU0ZvbnRTaXplQXR0cmlidXRlXxAYTlNDVEZvbnRVSVVzYWdlQXR0cmlidXRlI0BCGzycaIDyXxAVQ1RGb250RW1waGFzaXplZFVzYWdl0hgZZmdcTlNEaWN0aW9uYXJ5omYe0hgZaWpfEBBVSUZvbnREZXNjcmlwdG9yomseXxAQVUlGb250RGVzY3JpcHRvctMYGW1ub3BbJGNsYXNzaGludHNWVUlGb250om4eoS/YcnN0dXYOd3h5ent8fX5/TV8QFVVJQ29sb3JDb21wb25lbnRDb3VudFdVSUdyZWVuVlVJQmx1ZVdVSUFscGhhVU5TUkdCVVVJUmVkXE5TQ29sb3JTcGFjZRAEIj4ToygiPoQ6oSI/gAAATxARMC40NzMgMC4xNDQgMC4yNTiAGCI+8fg+0xgZbYGCg1dVSUNvbG9yooEeoYRXTlNDb2xvctIYGYaHXxAZTlNNdXRhYmxlQXR0cmlidXRlZFN0cmluZ6OIiR5fEBlOU011dGFibGVBdHRyaWJ1dGVkU3RyaW5nXxASTlNBdHRyaWJ1dGVkU3RyaW5nAAgAEQAaACQAKQAyADcASQBMAFEAUwBwAHYAfQCGAI0AmgCcAJ4AoAClAK8AsQDAAMUA0ADZAOsA7wEBAQoBEwEaASIBLQEyATQBNgE4AToBPwFBAUMBRQFHAUkBXAFxAXgBgAGHAZwBpwGpAasBrQGyAcwB0AHqAf0B/gIVAjoCVgJpAnACdwKEApYCsgK9AsoC0wLVAtcC4ALiAuQC7QLvAvEC8gMBAwgDIgM/A0QDRgNIA08DUgNUA1YDWQNbA10DXwN1A5ADmQOxA7YDwwPGA8sD3gPhA/QD+wQHBA4EEQQTBCQEPAREBEsEUwRZBF8EbARuBHMEeAR9BJEEkwSYBJ8EpwSqBKwEtAS5BNUE2QT1AAAAAAAAAgEAAAAAAAAAigAAAAAAAAAAAAAAAAAABQo=",
                        ], minHeight: 200, minWidth: 200, maxHeight: 800, maxWidth: 800,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(
                        x: 41.64008270211636, y: 689.5368020589401, width: 430.4784046901912,
                        height: 200),
                    data: WindowData(
                        type: .notes,
                        saveData: [
                            "richTextEditorKey":
                                "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dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6SXB0YzR4bXBFeHQ9Imh0dHA6Ly9pcHRjLm9yZy9zdGQvSXB0YzR4bXBFeHQvMjAwOC0wMi0yOS8iIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiBwaG90b3Nob3A6Q3JlZGl0PSJBcHBsZSBJbWFnZSBQbGF5Z3JvdW5kIiBJcHRjNHhtcEV4dDpEaWdpdGFsU291cmNlVHlwZT0iaHR0cDovL2N2LmlwdGMub3JnL25ld3Njb2Rlcy9kaWdpdGFsc291cmNldHlwZS90cmFpbmVkQWxnb3JpdGhtaWNNZWRpYSIgeG1wOkNyZWF0b3JUb29sPSJBcHBsZSBUZXh0S2l0Ij4gPGRjOmRlc2NyaXB0aW9uPiA8cmRmOkFsdD4gPHJkZjpsaSB4bWw6bGFuZz0ieC1kZWZhdWx0Ij5mYWNlIHdpdGggcmFpbmJvdyBzdW5nbGFzc2VzPC9yZGY6bGk+IDwvcmRmOkFsdD4gPC9kYzpkZXNjcmlwdGlvbj4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPD94cGFja2V0IGVuZD0idyI/PgAAAAAGRXhpZgAATU0AKgAAAAgABgENAAIAAAAmAAAAVgEOAAIAAAAdAAAAfAEeAAUAAAABAAAAmgEfAAUAAAABAAAAogExAAIAAAAOAAAAqodpAAQAAAABAAAAuAAAAAAzRkRDMDJENS03MkFDLTQwNjAtQUM4Mi1DOEUxQTFFRUZGMjgwAGZhY2Ugd2l0aCByYWluYm93IHN1bmdsYXNzZXMAAAAAAAAAAAABAAAAAAAAAAFBcHBsZSBUZXh0S2l0AAABpCAAAgAAACYAAADKAAAAADNGREMwMkQ1LTcyQUMtNDA2MC1BQzgyLUM4RTFBMUVFRkYyODAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNi4wLjAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOklwdGM0eG1wRXh0PSJodHRwOi8vaXB0Yy5vcmcvc3RkL0lwdGM0eG1wRXh0LzIwMDgtMDItMjkvIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgcGhvdG9zaG9wOkNyZWRpdD0iQXBwbGUgSW1hZ2UgUGxheWdyb3VuZCIgSXB0YzR4bXBFeHQ6RGlnaXRhbFNvdXJjZVR5cGU9Imh0dHA6Ly9jdi5pcHRjLm9yZy9uZXdzY29kZXMvZGlnaXRhbHNvdXJjZXR5cGUvdHJhaW5lZEFsZ29yaXRobWljTWVkaWEiIHhtcDpDcmVhdG9yVG9vbD0iQXBwbGUgVGV4dEtpdCI+IDxkYzpkZXNjcmlwdGlvbj4gPHJkZjpBbHQ+IDxyZGY6bGkgeG1sOmxhbmc9IngtZGVmYXVsdCI+ZmFjZSB3aXRoIHJhaW5ib3cgc3VuZ2xhc3NlczwvcmRmOmxpPiA8L3JkZjpBbHQ+IDwvZGM6ZGVzY3JpcHRpb24+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDw/eHBhY2tldCBlbmQ9InciPz4AAAAABkV4aWYAAE1NACoAAAAIAAYBDQACAAAAJgAAAFYBDgACAAAAHQAAAHwBHgAFAAAAAQAAAJoBHwAFAAAAAQAAAKIBMQACAAAADgAAAKqHaQAEAAAAAQAAALgAAAAAM0ZEQzAyRDUtNzJBQy00MDYwLUFDODItQzhFMUExRUVGRjI4MABmYWNlIHdpdGggcmFpbmJvdyBzdW5nbGFzc2VzAAAAAAAAAAAAAQAAAAAAAAABQXBwbGUgVGV4dEtpdAAAAaQgAAIAAAAmAAAAygAAAAAzRkRDMDJENS03MkFDLTQwNjAtQUM4Mi1DOEUxQTFFRUZGMjgwADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDYuMC4wIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxuczpJcHRjNHhtcEV4dD0iaHR0cDovL2lwdGMub3JnL3N0ZC9JcHRjNHhtcEV4dC8yMDA4LTAyLTI5LyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHBob3Rvc2hvcDpDcmVkaXQ9IkFwcGxlIEltYWdlIFBsYXlncm91bmQiIElwdGM0eG1wRXh0OkRpZ2l0YWxTb3VyY2VUeXBlPSJodHRwOi8vY3YuaXB0Yy5vcmcvbmV3c2NvZGVzL2RpZ2l0YWxzb3VyY2V0eXBlL3RyYWluZWRBbGdvcml0aG1pY01lZGlhIiB4bXA6Q3JlYXRvclRvb2w9IkFwcGxlIFRleHRLaXQiPiA8ZGM6ZGVzY3JpcHRpb24+IDxyZGY6QWx0PiA8cmRmOmxpIHhtbDpsYW5nPSJ4LWRlZmF1bHQiPmZhY2Ugd2l0aCByYWluYm93IHN1bmdsYXNzZXM8L3JkZjpsaT4gPC9yZGY6QWx0PiA8L2RjOmRlc2NyaXB0aW9uPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8P3hwYWNrZXQgZW5kPSJ3Ij8+AAAAAAZFeGlmAABNTQAqAAAACAAGAQ0AAgAAACYAAABWAQ4AAgAAAB0AAAB8AR4ABQAAAAEAAACaAR8ABQAAAAEAAACiATEAAgAAAA4AAACqh2kABAAAAAEAAAC4AAAAADNGREMwMkQ1LTcyQUMtNDA2MC1BQzgyLUM4RTFBMUVFRkYyODAAZmFjZSB3aXRoIHJhaW5ib3cgc3VuZ2xhc3NlcwAAAAAAAAAAAAEAAAAAAAAAAUFwcGxlIFRleHRLaXQAAAGkIAACAAAAJgAAAMoAAAAAM0ZEQzAyRDUtNzJBQy00MDYwLUFDODItQzhFMUExRUVGRjI4MAA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJYTVAgQ29yZSA2LjAuMCI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6SXB0YzR4bXBFeHQ9Imh0dHA6Ly9pcHRjLm9yZy9zdGQvSXB0YzR4bXBFeHQvMjAwOC0wMi0yOS8iIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiBwaG90b3Nob3A6Q3JlZGl0PSJBcHBsZSBJbWFnZSBQbGF5Z3JvdW5kIiBJcHRjNHhtcEV4dDpEaWdpdGFsU291cmNlVHlwZT0iaHR0cDovL2N2LmlwdGMub3JnL25ld3Njb2Rlcy9kaWdpdGFsc291cmNldHlwZS90cmFpbmVkQWxnb3JpdGhtaWNNZWRpYSIgeG1wOkNyZWF0b3JUb29sPSJBcHBsZSBUZXh0S2l0Ij4gPGRjOmRlc2NyaXB0aW9uPiA8cmRmOkFsdD4gPHJkZjpsaSB4bWw6bGFuZz0ieC1kZWZhdWx0Ij5mYWNlIHdpdGggcmFpbmJvdyBzdW5nbGFzc2VzPC9yZGY6bGk+IDwvcmRmOkFsdD4gPC9kYzpkZXNjcmlwdGlvbj4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPD94cGFja2V0IGVuZD0idyI/PgAAAAAGRXhpZgAATU0AKgAAAAgABgENAAIAAAAmAAAAVgEOAAIAAAAdAAAAfAEeAAUAAAABAAAAmgEfAAUAAAABAAAAogExAAIAAAAOAAAAqodpAAQAAAABAAAAuAAAAAAzRkRDMDJENS03MkFDLTQwNjAtQUM4Mi1DOEUxQTFFRUZGMjgwAGZhY2Ugd2l0aCByYWluYm93IHN1bmdsYXNzZXMAAAAAAAAAAAABAAAAAAAAAAFBcHBsZSBUZXh0S2l0AAABpCAAAgAAACYAAADKAAAAADNGREMwMkQ1LTcyQUMtNDA2MC1BQzgyLUM4RTFBMUVFRkYyODAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNi4wLjAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOklwdGM0eG1wRXh0PSJodHRwOi8vaXB0Yy5vcmcvc3RkL0lwdGM0eG1wRXh0LzIwMDgtMDItMjkvIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgcGhvdG9zaG9wOkNyZWRpdD0iQXBwbGUgSW1hZ2UgUGxheWdyb3VuZCIgSXB0YzR4bXBFeHQ6RGlnaXRhbFNvdXJjZVR5cGU9Imh0dHA6Ly9jdi5pcHRjLm9yZy9uZXdzY29kZXMvZGlnaXRhbHNvdXJjZXR5cGUvdHJhaW5lZEFsZ29yaXRobWljTWVkaWEiIHhtcDpDcmVhdG9yVG9vbD0iQXBwbGUgVGV4dEtpdCI+IDxkYzpkZXNjcmlwdGlvbj4gPHJkZjpBbHQ+IDxyZGY6bGkgeG1sOmxhbmc9IngtZGVmYXVsdCI+ZmFjZSB3aXRoIHJhaW5ib3cgc3VuZ2xhc3NlczwvcmRmOmxpPiA8L3JkZjpBbHQ+IDwvZGM6ZGVzY3JpcHRpb24+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDw/eHBhY2tldCBlbmQ9InciPz4AAAAX0SgBr5RcTcI2gkjAK2dsN/5IYtv3t9KfvgZ1bbHKvYCZkRg2Bim8r/QMmiPN4TrjFXHlMwxvJVvB+uUpY63ed2lgE1fPAqIgI1r99S9h17CKRvBgdEqZ3d0DjDh5VPjzcvT+6gu4lBJc4i/E+rlGaKCGU26RiWxCHiEfu5R4vx5lNAIwivNRFdJ6ZvX+adpvSIXqA/v4E1DA1+9IbiUBeZY8pmwGtpROupf1t4BlJB4nLxp+DBv+fe5p4q810MQ3hrWj9jR55WM/YlMmJ+Ha/KERzHZWxZii6hPO9r7FLuauwzFNVLncpt75MwtcMxtA351sHbjvH29p7+5QQYMnfaKPi0VOEnmZkupbS9z73Ghwjp44e3gCy+qtzY3/4PtBzouFevNEdSU/2kXyk017/AlW8LDEfaWP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TlNBZGFwdGl2ZUltYWdlR2x5cGiiAPkAIF8QFE5TQWRhcHRpdmVJbWFnZUdseXBo1AA7ADwAPQAQAD4APwBAAEGAAIAM0gAaABsA/gD/Xk5TTXV0YWJsZUFycmF5owEAAQEAIF5OU011dGFibGVBcnJheVdOU0FycmF50gEDABABBAEFV05TLmRhdGFIFAAFAQ4AAQKANtIAGgAbAQcBCF1OU011dGFibGVEYXRhowEJAQoAIF1OU011dGFibGVEYXRhVk5TRGF0YdIAGgAbAQwBDV8QGU5TTXV0YWJsZUF0dHJpYnV0ZWRTdHJpbmejAQ4BDwAgXxAZTlNNdXRhYmxlQXR0cmlidXRlZFN0cmluZ18QEk5TQXR0cmlidXRlZFN0cmluZwAIABkAIgAsADEAOgA/AFEAVgBbAF0A0ADWAOcA8AECAQ8BFgEYARoBHAEeAScBMQEzAYYBjwGaAaMBtQG8Ac4B1wHgAekB9AH7Af0B/wIBAgMCEAIYAiECIwIlAicCKQIyAjQCNgI4AjoCPAJRAmQCawJzAnQChQKQAqUCsQKzArUCtwK5AsIC3ALjAv0DEAM9A2IDfgORA5gDnwOsA74D2gPlA/ID+wP9A/8ECAQKBAwEDgQQBBEEHwQsBEYEYwRoBGoEbAR5BH4EgASCBIcEiQSLBI0EowS+BNME3ATpBO4E9wUKBQ8FIgUvBTsFQgVHBUoFawWDBYsFkgWaBaAFpgWzBbUFugW/BcQF2AXaBd8F4QXuBfYF+wX+BgYGEwYcBh4GIAYiBiQGLQYvBjEGMwY1BjcGTAZdBl8GYQaOBpAGkgaUBpYGmAaZBq8GvAa+BsAGzQbUBtYG2AbaBuEG4wblBucG6QcDBxgHJQcoByoHLQcvBzEHSQdLB2wHcQd2B4oHjAeRB54HqQerB60HrwexB7MHvgfAB8IHxAfGB8gHygfkB/kIJggoCCoIMwg1CD4IQAhCCEMIUAhSCFQIYQhmCGgIaghvCHEIcwh1CH4InwikCKkIvQi/CMQI0QjoCPoI/Aj+CQAJKMvcy+XL/MwBzBjMKcwrzC3MNsxFzEzMW8xjzGzMdMx9zH/MiMyWzJ3Mq8yyzLvM18zezPoAAAAAAAACAgAAAAAAAAEQAAAAAAAAAAAAAAAAAADNDw==",
                        ], minHeight: 200, minWidth: 200, maxHeight: 800, maxWidth: 800,
                        minAspectRatio: 0, maxAspectRatio: 1000000000, layer: 0), false),
                Window(
                    state: WindowState(x: 7.7297893706012815, y: -691, width: 280, height: 200),
                    data: WindowData(
                        type: .quote, saveData: [:], minHeight: 160, minWidth: 160, maxHeight: 440,
                        maxWidth: 440, minAspectRatio: 0.8, maxAspectRatio: 1.55, layer: 0), false),
            ],
            name: "Writing ✍️",
            cameraCenterX: -36.5,
            cameraCenterY: -126,
            cameraZoom: 0.85,
            showMarkers: false,
            markers: [
                SpaceMarker(x: 179.5, y: -826.5, zoom: 0.8504435420036316),
                SpaceMarker(x: -14.5, y: 567.5, zoom: 0.85),
                SpaceMarker(x: -36.5, y: -126, zoom: 0.85),
            ],
            disableDots: false,
            lockCamera: false,
            disableOrganizeWindows: false)
    }
}
