//
//  AddView.swift
//  iExpense
//
//  Created by Mohit Sengar on 30/11/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var amount: Double = 0.0
    @State private var type: String = "Personal"
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    var expenses : Expense
    let types = ["Business","Personal"]
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Enter name", text: $name)
                Picker("Select type", selection: $type){
                    ForEach(types, id:\.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                TextField("Enter amount", value:$amount, format: .currency(code: "INR"))
                    .keyboardType(.decimalPad)
                
            }.navigationTitle("Add new expense")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    Button("Save"){
                        if name.isEmpty || amount == 0.0{
                            alertTitle = "Error"
                            alertMessage = "Please fill all the fields"
                            showingAlert.toggle()
                            return
                        }
                        let expense = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(expense)
                        dismiss()
                    }
                }
                .alert(alertTitle, isPresented: $showingAlert, actions: {}, message: {Text(alertMessage)})
        }
    }
}

#Preview {
    AddView(expenses: Expense())
}
