//
//  IncomeList.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 05/01/2024.
//

import SwiftUI

class IncomeList : ObservableObject {
    typealias Income = IncomeModel.Income
    
    @Published var incomeModel = IncomeModel(incomes: [])
    
    var incomes: Array<Income> {
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
    
    var getTotal: Float {
        var total: Float = 0
        for income in incomes {
            total += income.amount
        }
        return total
    }
    
    func delete(atOffset: IndexSet){
        print(atOffset)
        //Incomes.remove(atOffsets: atOffset)
    }
    
    func fetchSingleIcome(id: UUID) async throws -> Income{
        let response: Income = try await fetchSingleObject(urlPath: "incomes", id: id)
        return response
    }
    
    func fetchIncomesWithDate(year: Int, month: String) async throws {
        let response: [Income] = try await fetchObjectWithDate(urlPath: "incomes", year: year, month: month)
        
        DispatchQueue.main.async {
            self.incomeModel.incomes = response
        }
    }
}
