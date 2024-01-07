//
//  ExpenseModel.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 31/12/2023.
//

import Foundation

struct ExpenseModel {
    
    var expenses: [Expense]
    
    struct Expense: Identifiable, Codable, Hashable {
        var id: UUID
        var title: String
        var amount: Float
        var createdAt: Date
    }
}
