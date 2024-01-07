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
}