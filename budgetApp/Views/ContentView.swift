//
//  ContentView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 27/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    var expenseList: ExpenseList
    var incomeList: IncomeList
    var overViewList: OverViewList
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Menu("add", systemImage: "plus"){
                    Button("Add expense", systemImage: "eurosign") {
                        print("test1")
                    }
                    Button("Add income", systemImage: "eurosign.square"){
                        print("test2")
                    }
                }
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
            }
        }
    }
}

#Preview {
    ContentView(expenseList: ExpenseList(), incomeList: IncomeList(), overViewList: OverViewList())
}
