import SwiftUI

struct SettingsView: View {
    @AppStorage("numberOfGoals") private var numberOfGoals: Int = 10
    @AppStorage("notificationHour") private var notificationHour: Int = 8
    @AppStorage("notificationMinute") private var notificationMinute: Int = 0
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = true

    @ObservedObject var localizationManager = LocalizationManager.shared

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Daily Goals".localized())) {
                    Stepper(value: $numberOfGoals, in: 1...20) {
                        Text(String(format: "Number of Goals: %d".localized(), numberOfGoals))
                    }
                }

                Section(header: Text("Notifications".localized())) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Enable Notifications".localized())
                    }
                    .onChange(of: notificationsEnabled) { enabled in
                        if enabled {
                            NotificationManager.shared.scheduleDailyNotification(hour: notificationHour, minute: notificationMinute)
                        } else {
                            NotificationManager.shared.cancelNotifications()
                        }
                    }

                    if notificationsEnabled {
                        DatePicker(
                            "Notification Time".localized(),
                            selection: Binding(
                                get: {
                                    var components = DateComponents()
                                    components.hour = notificationHour
                                    components.minute = notificationMinute
                                    return Calendar.current.date(from: components) ?? Date()
                                },
                                set: { newDate in
                                    let components = Calendar.current.dateComponents([.hour, .minute], from: newDate)
                                    notificationHour = components.hour ?? 8
                                    notificationMinute = components.minute ?? 0

                                    // Reschedule the notification with the new time if notifications are enabled
                                    if notificationsEnabled {
                                        NotificationManager.shared.scheduleDailyNotification(hour: notificationHour, minute: notificationMinute)
                                    }
                                }
                            ),
                            displayedComponents: .hourAndMinute
                        )
                        .onChange(of: notificationHour) { _ in
                            if notificationsEnabled {
                                NotificationManager.shared.scheduleDailyNotification(hour: notificationHour, minute: notificationMinute)
                            }
                        }
                        .onChange(of: notificationMinute) { _ in
                            if notificationsEnabled {
                                NotificationManager.shared.scheduleDailyNotification(hour: notificationHour, minute: notificationMinute)
                            }
                        }
                    }
                }

                Section(header: Text("Language".localized())) {
                    Picker(selection: $localizationManager.currentLanguage, label: Text("Select Language".localized())) {
                        ForEach(localizationManager.supportedLanguages) { language in
                            Text(language.displayName).tag(language)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            .navigationTitle("Settings".localized())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
