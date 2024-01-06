//
//  IncomeList.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 05/01/2024.
//

import SwiftUI

class IncomeList : ObservableObject {
    @Published var incomeModel = IncomeModel(incomes: [])
    
    var incomes: Array<IncomeModel.Income> {
        return incomeModel.incomes
    }
    
    var getTotal: Float {
        var total: Float = 0
        for income in incomes {
            total += income.amount
        }
        return total
    }
    
    func fetchIncomesWithDate(year: Int, month: String) async throws {
        let response: [IncomeModel.Income] = try await fetchObjectWithDate(urlPath: "incomes", year: year, month: month)
        
        DispatchQueue.main.async {
            self.incomeModel.incomes = response
        }
    }
}
