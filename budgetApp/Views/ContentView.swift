//
//  ContentView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 27/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    var expenseList: ExpenseList
    
    var body: some View {
        
            TabView {
                Text("Tab 1")
                    .tabItem {
                        Label("All", systemImage: "square.grid.2x2")
                    }
                ExpensesView(expenseList: expenseList)
                    .tabItem {
                        Label("Expenses", systemImage: "dollarsign")
                    }
                Text("Tab 3")
                    .tabItem {
                        Label("Income",
                              systemImage: "dollarsign.square")
                    }
            }
    }
}

#Preview {
    ContentView(expenseList: ExpenseList())
}
