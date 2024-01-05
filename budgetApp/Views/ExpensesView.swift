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
            Section(header: SectionHeader(title:"expenses", expenseList: expenseList))//TODO: totaal veranderen
            {
                list
            }
        }
    }
    
    var list: some View {
        List {
            ForEach(expenseList.expenses) { expense in
                NavigationLink(value: expense.id) {
                    VStack (alignment: .leading) {
                        Text(expense.title).font(.headline).fontWeight(.bold)
                        HStack{
                            Text("€ -\(expense.amount, specifier: "%.2f")")
                            Spacer()
                            Text("\(expense.createdAt.formatted(.dateTime.day().month().year()))")
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
