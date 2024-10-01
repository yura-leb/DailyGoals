import SwiftUI

struct MainView: View {
    @AppStorage("numberOfGoals") private var numberOfGoals: Int = 10
    @State private var goals: [String] = []
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0..<numberOfGoals, id: \.self) { index in
                        TextField(String(format: "Goal %d".localized(), index + 1), text: Binding(
                            get: {
                                if index < goals.count {
                                    return goals[index]
                                } else {
                                    goals.append("")
                                    return ""
                                }
                            },
                            set: { newValue in
                                if index < goals.count {
                                    goals[index] = newValue
                                } else {
                                    goals.append(newValue)
                                }
                            }
                        ))
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(5)
                    }
                }

                Button(action: saveGoals) {
                    Text("Save".localized())
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Goals Saved".localized()),
                        message: Text("Your goals for today have been saved.".localized()),
                        dismissButton: .default(Text("OK".localized()))
                    )
                }
            }
            .navigationTitle("Today's Goals".localized())
            .onAppear {
                adjustGoalsArray()
            }
            .onChange(of: numberOfGoals) { _ in
                adjustGoalsArray()
            }
        }
    }

    func adjustGoalsArray() {
        if goals.count < numberOfGoals {
            goals.append(contentsOf: Array(repeating: "", count: numberOfGoals - goals.count))
        } else if goals.count > numberOfGoals {
            goals = Array(goals.prefix(numberOfGoals))
        }
    }

    func saveGoals() {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateKey = formatter.string(from: today)

        var savedGoals = UserDefaults.standard.dictionary(forKey: "SavedGoals") as? [String: [String]] ?? [:]
        savedGoals[dateKey] = goals.filter { !$0.isEmpty }

        UserDefaults.standard.set(savedGoals, forKey: "SavedGoals")
        showingAlert = true
        goals = Array(repeating: "", count: numberOfGoals)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
