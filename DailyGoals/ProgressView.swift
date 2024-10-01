// ProgressView.swift

import SwiftUI

struct ProgressView: View {
    @State private var savedGoals: [String: [String]] = [:]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(savedGoals.keys.sorted(by: >), id: \.self) { date in
                    Section(header: Text(date).font(.headline)) {
                        ForEach(savedGoals[date]!, id: \.self) { goal in
                            Text("• \(goal)")
                                .padding(.vertical, 2)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Your Progress".localized())
            .onAppear(perform: loadGoals)
        }
    }
    
    func loadGoals() {
        if let savedGoalsData = UserDefaults.standard.dictionary(forKey: "SavedGoals") as? [String: [String]] {
            savedGoals = savedGoalsData
        } else {
            savedGoals = [:]
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
