//
//  ContentView.swift
//  iExpense
//
//  Created by Mohit Sengar on 29/11/25.
//
import SwiftUI

@Observable
class User{
    var firstName = "Mohit"
    var lastName = "Sengar"
}
// Use the class to store because when we use struct it will work but whenever the values update it will create the multiple copies of that struct on every change.

struct ContentView: View {
    @State private var user = User()
    @State private var showingSheet: Bool = false
    
    var body: some View {
        VStack {
            Text("My Name is \(user.firstName) \(user.lastName)")
            
            TextField("Enter your first name", text: $user.firstName) // here note that when the whole class is observable then all the variables will be used as the observable and also marked as state then they work as observable objects to store and work on.
            TextField("Enter your last name",text: $user.lastName)
            
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
