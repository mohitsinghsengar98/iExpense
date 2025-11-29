//
//  ContentView.swift
//  iExpense
//
//  Created by Mohit Sengar on 29/11/25.
//

import SwiftUI

struct ExpenseItem{
    let name:String
    let type:String
    let amount :Double
}

@Observable
class Expense{
    var items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var expenses = Expense()
    
    var body: some View {
        NavigationStack{
            VStack {
                List{
                    ForEach(expenses.items, id:\.name){ item in
                        Text(item.name)
                    }.onDelete(perform: removeItem)
                }
            }
            .padding()
            .navigationTitle("iExpense")
            .toolbar{
                Button("Add Expense",systemImage: "plus"){
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    expenses.items.append(expense)
                }
            }
        }
    }
    
    func removeItem(at offsets:IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
