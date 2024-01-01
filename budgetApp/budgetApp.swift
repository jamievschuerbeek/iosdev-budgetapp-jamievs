//
//  budgetApp.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 27/12/2023.
//

import SwiftUI

@main
struct budgetApp: App {
    @StateObject var expenses = ExpenseList()
    
    var body: some Scene {
        WindowGroup {
            ContentView(expenseList: expenses)
        }
    }
}
