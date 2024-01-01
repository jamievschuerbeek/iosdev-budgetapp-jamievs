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
        let urlString = "https://a21f-2a02-1811-cc1f-2300-1952-8069-d7ba-31ca.ngrok-free.app/expenses"
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let response: [ExpenseModel.Expense] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.expenseModel.expenses = response
        }
    }
}
