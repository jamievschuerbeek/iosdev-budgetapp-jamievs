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
        let dataUrl = "https://f4c9-2a02-1811-cc1f-2300-b9dc-4810-9d6b-f346.ngrok-free.app"
        let urlString = "\(dataUrl)/expenses"
        
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let response: [ExpenseModel.Expense] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.expenseModel.expenses = response
        }
    }
}
