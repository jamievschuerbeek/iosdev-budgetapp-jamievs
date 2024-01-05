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
    
    //TODO: Deze niet meer gebruiken, vervangen door fetchExpensesWithDate
    func fetchExpenses() async throws {
        
        let response: [ExpenseModel.Expense] = try await fetchObject(urlPath: "expenses")
        
        DispatchQueue.main.async {
            self.expenseModel.expenses = response
        }
    }
    
    func fetchExpensesWithDate(year: Int, month: String) async throws {
        let response: [ExpenseModel.Expense] = try await fetchObjectWithDate(urlPath: "expenses", year: year, month: month)
        
        DispatchQueue.main.async {
            self.expenseModel.expenses = response
        }
    }
}
