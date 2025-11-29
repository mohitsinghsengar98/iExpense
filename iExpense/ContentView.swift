//
//  ContentView.swift
//  iExpense
//
//  Created by Mohit Sengar on 29/11/25.
//
import Observation // this is to see the implementation of the @observable macro.
import SwiftUI

@Observable
class User{
    var firstName = "Mohit"
    var lastName = "Sengar"
}
// Use the class to store because when we use struct it will work but whenever the values update it will create the multiple copies of that struct on every change.

struct ContentView: View {
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("My Name is \(user.firstName) \(user.lastName)")
            
            TextField("Enter your first name", text: $user.firstName) // here note that when the whole class is observable then all the variables will be used as the observable and also marked as state then they work as observable objects to store and work on.
            TextField("Enter your last name",text: $user.lastName)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
