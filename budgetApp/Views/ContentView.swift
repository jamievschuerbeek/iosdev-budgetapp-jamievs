//
//  ContentView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 27/12/2023.
//

import SwiftUI

struct ContentView: View {
    
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
        .padding()
    }
}

#Preview {
    ContentView(expenseList: ExpenseList())
}
