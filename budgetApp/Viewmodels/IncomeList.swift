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
    
    func delete(at offsets: IndexSet){
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
    
    func add(title: String, amount: Float) async throws{
        let income = Income(id: nil, title: title, amount: amount, createdAt: nil)
        
        try await addObject(urlPath: "incomes", object: income)
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
