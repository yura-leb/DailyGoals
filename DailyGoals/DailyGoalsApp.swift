import SwiftUI

@main
struct DailyGoalsApp: App {
    @ObservedObject var localizationManager = LocalizationManager.shared

    init() {
        // Request notification authorization when the app launches
        NotificationManager.shared.requestAuthorization()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(localizationManager)
        }
    }
}
