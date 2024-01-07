//
//  overViewList.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 05/01/2024.
//

import SwiftUI

class OverViewList : ObservableObject {
    @Published var incomeModel = IncomeModel(incomes: [])
    @Published var expenseModel = ExpenseModel(expenses: [])
    
    var incomes: Array<IncomeModel.Income> {
        get {
            return incomeModel.incomes
        }
        set {
            if !newValue.isEmpty {
                incomeModel.incomes = newValue
                objectWillChange.send()
            }
        }
    }
    
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
        var incomeTotal: Float = 0
        var expenseTotal: Float = 0
        for income in incomes {
            incomeTotal += income.amount
        }
        for expense in expenses {
            expenseTotal += expense.amount
        }
        return incomeTotal - expenseTotal
    }
    
    func fetchOverViewWithDate(year: Int, month: String) async throws {
        let response: [IncomeModel.Income] = try await fetchObjectWithDate(urlPath: "incomes", year: year, month: month)
        let expenseResponse: [ExpenseModel.Expense] = try await fetchObjectWithDate(urlPath: "expenses", year: year, month: month)
        
        DispatchQueue.main.async {
            self.incomeModel.incomes = response
            self.expenseModel.expenses = expenseResponse
        }
    }
    
    func deleteExpense(at offsets: IndexSet){
        offsets.forEach { index in
            guard let expenseId = expenseModel.expenses[index].id else {
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
    
    func deleteIncome(at offsets: IndexSet){
        offsets.forEach { index in
            guard let incomeId = incomes[index].id else {
                return
            }
            guard let url = URL(string: "\(dataUrl)/incomes/\(incomeId)") else {
                return
            }
            
            Task {
                do {
                    try await HttpClient.shared.delete(at: incomeId, url: url)
                } catch {
                    print("Error deleting: \(error)")
                }
            }
        }
        
        incomeModel.incomes.remove(atOffsets: offsets)
    }
}
