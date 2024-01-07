//
//  ContentView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 27/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var expenseList: ExpenseList
    @ObservedObject var incomeList: IncomeList
    @ObservedObject var overViewList: OverViewList
    
    @State var showForm: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Menu("add", systemImage: "plus"){
                        Button("Add expense", systemImage: "eurosign") {
                            showForm = true
                        }
                        Button("Add income", systemImage: "eurosign.square"){
                            showForm = true
                        }
                    }.foregroundStyle(.blue)
                }.padding()
                TabView {
                    OverViewListView(overViewList: overViewList)
                        .tabItem {
                            Label("All", systemImage: "square.grid.2x2")
                        }
                    ExpensesView(expenseList: expenseList)
                        .tabItem {
                            Label("Expenses", systemImage: "eurosign")
                        }
                    IncomesView(incomeList: incomeList)
                        .tabItem {
                            Label("Income",
                                  systemImage: "eurosign.square")
                        }
                }.navigationDestination(isPresented: $showForm){
                    CreateForm(expenseList: expenseList)
                }.navigationDestination(for: IncomeModel.Income.ID.self) { incomeId in
                    if let index = incomeList.incomes.firstIndex(where: { $0.id == incomeId }) {
                        TransactionDetailsView(transaction: $incomeList.incomes[index])
                    } else if let index = overViewList.incomes.firstIndex(where: { $0.id == incomeId }) {
                        TransactionDetailsView(transaction: $overViewList.incomes[index])
                    }
                }
                .navigationDestination(for: ExpenseModel.Expense.self) { expense in
                    if let index = expenseList.expenses.firstIndex(where: { $0.id == expense.id }) {
                        TransactionDetailsView(transaction: $expenseList.expenses[index])
                    } else if let index = overViewList.expenses.firstIndex(where: { $0.id == expense.id }) {
                        TransactionDetailsView(transaction: $overViewList.expenses[index])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(expenseList: ExpenseList(), incomeList: IncomeList(), overViewList: OverViewList())
}
