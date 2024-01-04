//
//  ExpenseList.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 31/12/2023.
//

import SwiftUI

class ExpenseList : ObservableObject {
    @Published var expenseModel = ExpenseModel(expenses: [])
    
    var expenses: Array<ExpenseModel.Expense> {
        return expenseModel.expenses
    }
    
    func fetchExpenses() async throws {
        
        let response: [ExpenseModel.Expense] = try await fetchObject(urlPath: "expenses")
        
        DispatchQueue.main.async {
            self.expenseModel.expenses = response
        }
    }
}
