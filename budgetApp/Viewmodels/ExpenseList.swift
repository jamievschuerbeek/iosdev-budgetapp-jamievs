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
        get {
            return expenseModel.expenses
        }
        set{
            if !newValue.isEmpty {
                expenseModel.expenses = newValue
            }
        }
    }
    
    var getTotal: Float {
        var total: Float = 0
        for expense in expenses {
            total += expense.amount
        }
        return total
    }
    
    func delete(at offsets: IndexSet){
        offsets.forEach { index in
            guard let expenseId = expenseModel.expenses[index].id else{
                return
            }
            guard let url = URL(string: "\(dataUrl)/expenses/\(expenseId)") else {
                return
            }
            
            Task {
                do {
                    try await HttpClient.shared.delete(at: expenseId, url: url)
                } catch {
                    print("Error deleting: \(error)")
                }
            }
        }
        expenseModel.expenses.remove(atOffsets: offsets)
    }
    
    func add(title: String, amount: Float) async throws{
        let expense = ExpenseModel.Expense(id: nil, title: title, amount: amount, createdAt: nil)
        
        try await addObject(urlPath: "expenses", object: expense)
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
