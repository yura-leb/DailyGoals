import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                let notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
                if notificationsEnabled {
                    let hour = UserDefaults.standard.integer(forKey: "notificationHour")
                    let minute = UserDefaults.standard.integer(forKey: "notificationMinute")
                    self.scheduleDailyNotification(hour: hour, minute: minute)
                }
            } else {
                if let error = error {
                    print("Notification authorization error: \(error.localizedDescription)")
                } else {
                    print("Notification authorization denied.")
                }
            }
        }
    }

    func scheduleDailyNotification(hour: Int, minute: Int) {
        // Remove existing notifications
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["DailyGoalNotification"])

        let notificationsEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")
        guard notificationsEnabled else {
            print("Notifications are disabled.")
            return
        }

        let content = UNMutableNotificationContent()
        content.title = "Set Your Goals".localized()
        content.body = "Don't forget to set your goals for today.".localized()
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "DailyGoalNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Daily goal notification scheduled at \(hour):\(minute).")
            }
        }
    }

    func cancelNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["DailyGoalNotification"])
        print("Notifications have been canceled.")
    }
}
