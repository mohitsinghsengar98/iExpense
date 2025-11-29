//
//  ContentView.swift
//  iExpense
//
//  Created by Mohit Sengar on 29/11/25.
//
import SwiftUI

@Observable
class User:Codable{ // create this codeable to be able to save it later in user defaults.
    var firstName : String
    var lastName : String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
// Use the class to store because when we use struct it will work but whenever the values update it will create the multiple copies of that struct on every change.

struct ContentView: View {
    @State private var user = User(firstName:"Saurav", lastName: "Kapoor")
    @State private var showingSheet: Bool = false
    @AppStorage("tapCount") private var tapCount = 0 // App storage do same as using the userdefaults.
    
    var body: some View {
        VStack {
            Text("My Name is \(user.firstName) \(user.lastName)")
            
            TextField("Enter your first name", text: $user.firstName) // here note that when the whole class is observable then all the variables will be used as the observable and also marked as state then they work as observable objects to store and work on.
            TextField("Enter your last name",text: $user.lastName)
            
            Button("Tap count: \(tapCount)"){
                tapCount += 1
            }
            
            Button("Save Data"){
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(user){
                    UserDefaults.standard.set(data, forKey: "userData")
                }
            }
            
            Button("Open New View"){
                showingSheet.toggle()
            }
        }.sheet(isPresented: $showingSheet){
            NewScreenView(name: "\(user.firstName) \(user.lastName)")
        }
        .padding()
    }
}

struct NewScreenView: View {
    @Environment(\.dismiss) var dismiss // to fetch the defined global dismiss method and used it in our struct.
    let name : String
    @State private var numbers  = [Int]()
    @State private var currentNumber = 0
    
    var body: some View {
        NavigationStack{
            VStack{
                Text(name)
                List{
                    ForEach(numbers, id:\.self){
                        Text("Row \($0)")
                    }.onDelete(perform: removeRow) // ondelete func is available only inside the foreach means for dynamic rows only.
                }
                
                HStack{
                    Button("Dismiss"){
                        dismiss()
                    }.padding()
                        .buttonStyle(.borderedProminent)
                    
                    Button("Add Row"){
                        currentNumber += 1
                        numbers.append(currentNumber)
                    }.padding()
                        .buttonStyle(.borderedProminent)
                }
            }.toolbar(content: {
                EditButton()
            })
        }
    }
    
    func removeRow(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
