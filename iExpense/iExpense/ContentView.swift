//
//  ContentView.swift
//  iExpense
//
//  Created by Sajid Shanta on 4/11/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Business")) {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                 
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section(header: Text("Personal")) {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }

                                Spacer()
                                
                             Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddView = true
                } label:  {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//var ammount = item.amount
//if ammount >= 10.0 {
//    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//        .foregroundColor(.green)
//} else if ammount >= 100.0 {
//    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//        .foregroundColor(.blue)
//} else {
//    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//        .foregroundColor(.yellow)
//}
