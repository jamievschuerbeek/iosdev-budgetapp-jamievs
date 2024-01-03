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
            Section(header: VStack {
                Text("Expenses")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Total: $100,00") //TODO: Deze aanpassen naar echt totaal
            }
                .padding()
                .frame(
                    maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                    alignment: .leading)) {
                        List {
                            ForEach(expenseList.expenses) { expense in
                                NavigationLink(value: expense.id) {
                                    VStack (alignment: .leading) {
                                        Text(expense.title)
                                        Text("€ \(expense.amount, specifier: "%.2f")")
                                    }
                                }
                            }
                            
                        }
                        .onAppear {
                            Task {
                                do {
                                    try await expenseList.fetchExpenses()
                                } catch {
                                    print("Error: \(error)")
                                }
                            }
                        }
                    }
        }
    }
}

#Preview {
    ExpensesView(expenseList: ExpenseList())
}