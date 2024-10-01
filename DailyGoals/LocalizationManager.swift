// LocalizationManager.swift

import Foundation
import SwiftUI

class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()
    
    // Supported languages with their locale codes and display names
    let supportedLanguages: [Language] = [
        Language(languageCode: "en", displayName: "English"),
        Language(languageCode: "fr", displayName: "Français"),
        Language(languageCode: "de", displayName: "Deutsch"),
        Language(languageCode: "ru", displayName: "Русский")
    ]
    
    @Published var currentLanguage: Language {
        didSet {
            UserDefaults.standard.set(currentLanguage.languageCode, forKey: "SelectedLanguage")
            Bundle.setLanguage(currentLanguage.languageCode)
            // Reschedule notifications to update localized content
            let hour = UserDefaults.standard.integer(forKey: "notificationHour")
            let minute = UserDefaults.standard.integer(forKey: "notificationMinute")
            NotificationManager.shared.scheduleDailyNotification(hour: hour, minute: minute)
        }
    }
    
    private init() {
        // Retrieve saved language or default to English
        if let savedLanguageCode = UserDefaults.standard.string(forKey: "SelectedLanguage"),
           let savedLanguage = supportedLanguages.first(where: { $0.languageCode == savedLanguageCode }) {
            self.currentLanguage = savedLanguage
        } else {
            self.currentLanguage = supportedLanguages[0] // Default to English
        }
        Bundle.setLanguage(currentLanguage.languageCode)
    }
}

struct Language: Identifiable, Equatable, Hashable {
    let id = UUID()
    let languageCode: String
    let displayName: String
}
