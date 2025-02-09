import SwiftData
import SwiftUI

struct Window: Codable {
    var id: UUID

    var state: WindowState
    var data: WindowData

    init(
        state: WindowState = .init(),
        data: WindowData = .init(),
        _ applyDefaults: Bool = true
    ) {
        self.id = UUID()

        if applyDefaults {
            self.data = WindowData.applyDefaults(baseData: data)
            self.state = WindowState.applyDefaults(type: data.type, baseState: state)
        } else {
            self.data = data
            self.state = state
        }
    }
}

// WindowState stores the dimension and position of the window. Due to its changeable nature, it's managed by windows themselves, but it's also stored in model context in order to persist. Windows will choose specific occasions, like right after finishing dragging, to sync its version of WindowState with the model context. This means individual windows only need its own copy of state and its UUID which is used to link itself to the model context.
// In short, WindowState is kept and managed by windows themselves and only synced to the model context at select occasions.
// UPDATE: Looks like model context is able to manage this efficiently. So I might as well remove this distinction. Consider window state just another form of window data. It will now be directly managed by the model context.
struct WindowState: Codable {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 100
    var height: CGFloat = 100

    static func applyDefaults(type: WindowType, baseState: WindowState) -> WindowState {
        var updatedState = baseState
        updatedState.width = type.defaultSize.width
        updatedState.height = type.defaultSize.height
        return updatedState
    }
}

// WindowData is directly tied to the model context, meaning that individual windows won't keep their own version of the window data, and every change happens directly at the app data level. It's still mutable, but much less needed compared to WindowState, so the performance impact is minimal.
// In short, WindowData is only kept by the model context. Windows directly read WindowData from model context and makes changes on the model context directly.
struct WindowData: Codable {
    var type: WindowType
    var saveData: [String: String]
    var minHeight: CGFloat
    var minWidth: CGFloat
    var maxHeight: CGFloat
    var maxWidth: CGFloat
    var minAspectRatio: CGFloat
    var maxAspectRatio: CGFloat
    var layer: Int

    init(
        type: WindowType = .blank,
        saveData: [String: String] = [:],
        minHeight: CGFloat = 0,
        minWidth: CGFloat = 0,
        maxHeight: CGFloat = 1_000_000_000,
        maxWidth: CGFloat = 1_000_000_000,
        minAspectRatio: CGFloat = 0,
        maxAspectRatio: CGFloat = 1_000_000_000,
        layer: Int = 0
    ) {
        self.type = type
        self.saveData = saveData
        self.minHeight = minHeight
        self.minWidth = minWidth
        self.maxHeight = maxHeight
        self.maxWidth = maxWidth
        self.minAspectRatio = minAspectRatio
        self.maxAspectRatio = maxAspectRatio
        self.layer = layer
    }

    static func applyDefaults(baseData: WindowData) -> WindowData {
        var updatedData = baseData

        switch updatedData.type {
        case .notes:
            updatedData.maxHeight = 800
            updatedData.maxWidth = 800
            updatedData.minHeight = 200
            updatedData.minWidth = 200
        case .blank:
            updatedData.maxHeight = 800
            updatedData.maxWidth = 800
            updatedData.minHeight = 100
            updatedData.minWidth = 100
        case .clock:
            updatedData.maxHeight = 450
            updatedData.maxWidth = 450
            updatedData.minHeight = 150
            updatedData.minWidth = 150
            updatedData.minAspectRatio = (sqrt(5) - 1) / 2
            updatedData.maxAspectRatio = (sqrt(5) + 1) / 2
        case .digitalClock:
            updatedData.maxHeight = 420
            updatedData.maxWidth = 420
            updatedData.minHeight = 120
            updatedData.minWidth = 120
            updatedData.minAspectRatio = 1
            updatedData.maxAspectRatio = 2
        case .themeMaker:
            updatedData.maxHeight = 676
            updatedData.maxWidth = 960
            updatedData.minHeight = 676
            updatedData.minWidth = 640
        case .stopwatch:
            updatedData.maxWidth = 420
            updatedData.minWidth = 280
            updatedData.maxHeight = 600
            updatedData.minHeight = 340
        case .dashboard:
            updatedData.maxWidth = 400
            updatedData.minWidth = 200
            updatedData.maxHeight = 330
            updatedData.minHeight = 300
        case .toDoList:
            updatedData.maxWidth = 400
            updatedData.minWidth = 180
            updatedData.maxHeight = 600
            updatedData.minHeight = 260
        case .magicGlobe:
            updatedData.maxHeight = 500
            updatedData.maxWidth = 500
            updatedData.minHeight = 150
            updatedData.minWidth = 150
            updatedData.minAspectRatio = 0.8333
            updatedData.maxAspectRatio = 1.2
        case .calculator:
            updatedData.maxWidth = 360
            updatedData.minWidth = 200
            updatedData.maxHeight = 360
            updatedData.minHeight = 360
        case .themePicker:
            updatedData.maxWidth = 228
            updatedData.minWidth = 228
            updatedData.maxHeight = 160
            updatedData.minHeight = 108
        case .quote:
            updatedData.maxWidth = 440
            updatedData.minWidth = 160
            updatedData.maxHeight = 440
            updatedData.minHeight = 160
            updatedData.minAspectRatio = 0.8
            updatedData.maxAspectRatio = 1.55
        case .writingPrompt:
            updatedData.maxWidth = 440
            updatedData.minWidth = 160
            updatedData.maxHeight = 440
            updatedData.minHeight = 160
            updatedData.minAspectRatio = 0.8
            updatedData.maxAspectRatio = 1.65
        case .pomodoroTimer:
            updatedData.maxWidth = 440
            updatedData.minWidth = 298
            updatedData.maxHeight = 280
            updatedData.minHeight = 220
        case .habitTracker:
            updatedData.maxWidth = 450
            updatedData.minWidth = 280
            updatedData.maxHeight = 600
            updatedData.minHeight = 260
        case .image:
            updatedData.maxHeight = 320
            updatedData.maxWidth = 320
            updatedData.minHeight = 134
            updatedData.minWidth = 320
        case .countdownTimer:
            updatedData.maxHeight = 420
            updatedData.maxWidth = 440
            updatedData.minHeight = 380
            updatedData.minWidth = 350
        case .importantDays:
            updatedData.maxHeight = 420
            updatedData.maxWidth = 440
            updatedData.minHeight = 380
            updatedData.minWidth = 350
        }

        return updatedData
    }
}

enum WindowType: String, Codable, CaseIterable {
    case clock
    case stopwatch
    case pomodoroTimer
    case digitalClock
    case themePicker
    case calculator
    case habitTracker
    case toDoList
    case notes
    case importantDays
    case countdownTimer
    case magicGlobe
    case image
    case quote
    case writingPrompt
    case dashboard
    case blank
    case themeMaker

    var defaultSize: (width: CGFloat, height: CGFloat) {
        switch self {
        case .blank: return (180, 180)
        case .notes: return (220, 280)
        case .clock: return (190, 190)
        case .digitalClock: return (240, 150)
        case .calculator: return (200, 360)
        case .themeMaker: return (700, 676)
        case .stopwatch: return (300, 360)
        case .dashboard: return (250, 320)
        case .toDoList: return (210, 310)
        case .magicGlobe: return (210, 210)
        case .themePicker: return (228, 108)
        case .quote: return (280, 200)
        case .writingPrompt: return (280, 184)
        case .pomodoroTimer: return (320, 220)
        case .habitTracker: return (300, 320)
        case .image: return (320, 134)
        case .countdownTimer: return (380, 380)
        case .importantDays: return (380, 380)
        }
    }

    var glyph: WindowGlyph {
        switch self {
        case .blank: return WindowGlyph(mode: .system, key: "square.dashed")
        case .notes: return WindowGlyph(mode: .system, key: "note.text")
        case .clock: return WindowGlyph(mode: .system, key: "deskclock")
        case .digitalClock: return WindowGlyph(mode: .custom, key: "DigitalClock")
        case .themeMaker: return WindowGlyph(mode: .system, key: "command")
        case .stopwatch: return WindowGlyph(mode: .system, key: "stopwatch")
        case .dashboard: return WindowGlyph(mode: .system, key: "mappin.and.ellipse")
        case .toDoList: return WindowGlyph(mode: .system, key: "list.bullet.rectangle.portrait")
        case .magicGlobe: return WindowGlyph(mode: .system, key: "moon.stars.circle")
        case .calculator: return WindowGlyph(mode: .custom, key: "Calculator")
        case .themePicker: return WindowGlyph(mode: .system, key: "paintpalette")
        case .quote: return WindowGlyph(mode: .system, key: "text.quote")
        case .writingPrompt: return WindowGlyph(mode: .system, key: "pencil.line")
        case .pomodoroTimer: return WindowGlyph(mode: .system, key: "timer")
        case .habitTracker: return WindowGlyph(mode: .system, key: "widget.small")
        case .image: return WindowGlyph(mode: .system, key: "photo")
        case .countdownTimer: return WindowGlyph(mode: .system, key: "minus.arrow.trianglehead.counterclockwise")
        case .importantDays: return WindowGlyph(mode: .system, key: "calendar")
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .blank:
            Color.clear
        case .notes:
            RichTextEditorView()
        case .clock:
            ClockWidget()
        case .digitalClock:
            DigitalClock()
        case .themeMaker:
            ThemeMaker()
                .padding(12)
                .frame(maxWidth: .infinity)
        case .stopwatch:
            StopwatchView()
        case .dashboard:
            DashboardView()
        case .toDoList:
            TodoListView()
        case .magicGlobe:
            FancyMetallicGlobeView()
        case .calculator:
            CalculatorView()
        case .themePicker:
            ThemePicker(selectedScreen: .constant(Screen()), hasThemeMakerButton: false, rowCount: 4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 20)
                .gesture(DragGesture().onChanged { _ in })
        case .quote:
            DailyQuoteView()
        case .writingPrompt:
            DailyWritingPromptView()
        case .pomodoroTimer:
            PomodoroTimerView()
        case .habitTracker:
            HabitTrackerView()
        case .image:
            ImagePickerView()
        case .countdownTimer:
            CountdownTimerView()
        case .importantDays:
            ImportantDatesView()
        }
    }
}

enum WindowGlyphMode: Codable {
    case system
    case custom
}

struct WindowGlyph: Codable {
    var mode: WindowGlyphMode
    var key: String
}
