//
//  IncomeModel.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 04/01/2024.
//

import Foundation

struct IncomeModel {
    
    var incomes: [Income]
    
    
    struct Income: Identifiable, Codable {
        var id: UUID
        var title: String
        var amount: Float
        var createdAt: Date
    }
}
