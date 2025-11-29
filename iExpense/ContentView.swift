//
//  ContentView.swift
//  iExpense
//
//  Created by Mohit Sengar on 29/11/25.
//

import SwiftUI

struct ExpenseItem:Identifiable,Codable{ // to tell this is identifiable. and now i can delete the id from for each.
    var id = UUID() // unique id every time.
    let name:String
    let type:String
    let amount :Double
}

@Observable
class Expense{
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expense()
    @State private var showingAddExpense = false
    
    var body: some View {
        ZStack{
            Color(.red).ignoresSafeArea()
        NavigationStack{
            
                VStack {
                    List{
                        ForEach(expenses.items){ item in
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
//                                        .font(.subheadline)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: "INR"))
                            }
                            
                        }.onDelete(perform: removeItem)
                    }
                }
                .padding()
                .navigationTitle("iExpense")
                .toolbar{
                    Button("Add Expense",systemImage: "plus"){
    //                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
    //                    expenses.items.append(expense)
                        showingAddExpense = true
                    }
                }
                .sheet(isPresented: $showingAddExpense, onDismiss: {
                    showingAddExpense = false
                }){
                    AddView(expenses:expenses)
                }
            }.scrollContentBackground(.hidden)    // for lists / scroll views
                .background(Color.clear) 
        }
    }
    
    func removeItem(at offsets:IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
