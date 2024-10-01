# DailyGoals

DailyGoals is an iOS application built with SwiftUI that helps users set, track, and manage their daily goals. The app provides a simple and intuitive interface for users to input their goals, view their progress, and customize their experience.

## Features

1. **Goal Setting**: Users can set a customizable number of daily goals.
2. **Progress Tracking**: View and track completed goals over time.
3. **Multilingual Support**: The app supports multiple languages, including English, French, German, and Russian.
4. **Customizable Notifications**: Set daily reminders to encourage goal-setting.
5. **Settings**: Customize the number of daily goals and notification preferences.
6. **Privacy-Preserving**: The app does not collect any personal data, ensuring privacy.

## Project Structure

The project is organized into several key components:

- `DailyGoalsApp.swift`: The main entry point of the application.
- `ContentView.swift`: The root view that manages the tab-based navigation.
- `MainView.swift`: Allows users to input and save their daily goals.
- `ProgressView.swift`: Displays the user's goal history and progress.
- `SettingsView.swift`: Provides options for customizing the app experience.
- `LocalizationManager.swift`: Manages the app's localization settings.
- `NotificationManager.swift`: Handles scheduling and managing notifications.

## Localization

The app supports multiple languages. Localized strings are stored in:

- `en.lproj/Localizable.strings` (English)
- `fr.lproj/Localizable.strings` (French)
- `de.lproj/Localizable.strings` (German)
- `ru.lproj/Localizable.strings` (Russian)

To add a new language, create a new `.lproj` folder with the appropriate `Localizable.strings` file.

## Notifications

Daily notifications are managed by the `NotificationManager` class. Users can customize notification times in the Settings view.

## Getting Started

To run the project:

1. Clone the repository.
2. Open `DailyGoals.xcodeproj` in Xcode.
3. Select your target device or simulator.
4. Build and run the project (⌘R).

## Requirements

- iOS 16.2+
- Xcode 14.2+
- Swift 5.0+
