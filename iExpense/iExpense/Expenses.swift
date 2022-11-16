//
//  Expenses.swift
//  iExpense
//
//  Created by Sajid Shanta on 4/11/22.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let deccoded = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = deccoded
                return
            }
        }
        items = []
    }
}
