import Testing
@testable import SevenMinWorkout

struct SevenMinWorkoutTests {
    @Test @MainActor func contentViewBuilds() {
        _ = ContentView()
    }
}
