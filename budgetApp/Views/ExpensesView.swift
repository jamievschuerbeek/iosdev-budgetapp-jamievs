//
//  ExpensesView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 03/01/2024.
//

import SwiftUI

struct ExpensesView: View {
    
    @ObservedObject var expenseList: ExpenseList

    var body: some View {
        VStack {
            List(expenseList.expenses) {
                Text($0.title)
            }
            .onAppear {
                Task {
                    do {
                        try await expenseList.fetchExpenses()
                    } catch {
                        print("Error")
                    }
                }
            }
        }
    }
}

#Preview {
    ExpensesView(expenseList: ExpenseList())
}
