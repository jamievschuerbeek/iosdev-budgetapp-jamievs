//
//  ContentView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 27/12/2023.
//

import SwiftUI

enum TransactionType {
    case expense
    case income
}

struct ContentView: View {
    
    @ObservedObject var expenseList: ExpenseList
    @ObservedObject var incomeList: IncomeList
    @ObservedObject var overViewList: OverViewList
    
    @State var showForm: Bool = false
    @State var typeForform: TransactionType?
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Menu("add", systemImage: "plus"){
                        Button("Add expense", systemImage: "eurosign") {
                            showForm = true
                            typeForform = .expense
                        }
                        Button("Add income", systemImage: "eurosign.square"){
                            showForm = true
                            typeForform = .income
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
                    CreateForm(expenseList: expenseList, incomeList: incomeList, transactionType: typeForform ?? .expense)
                }.navigationDestination(for: IncomeModel.Income.ID.self) { incomeId in
                    //show income details
                    if let index = incomeList.incomes.firstIndex(where: { $0.id == incomeId }) {
                        TransactionDetailsView(transaction: $incomeList.incomes[index])
                    } else if let index = overViewList.incomes.firstIndex(where: { $0.id == incomeId }) {
                        TransactionDetailsView(transaction: $overViewList.incomes[index])
                    }
                }
                .navigationDestination(for: ExpenseModel.Expense.self) { expense in
                    //show expense details
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
