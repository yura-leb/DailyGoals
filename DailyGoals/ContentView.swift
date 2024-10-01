// ContentView.swift

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var localizationManager: LocalizationManager
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Today".localized())
                }
            ProgressView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Progress".localized())
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings".localized())
                }
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocalizationManager.shared)
    }
}
