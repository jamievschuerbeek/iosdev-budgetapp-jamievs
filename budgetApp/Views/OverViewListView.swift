//
//  OverViewListView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 05/01/2024.
//

import SwiftUI

struct OverViewListView: View {
    @ObservedObject var overViewList: OverViewList
    
    var body: some View {
        VStack {
            Section(header: SectionHeader(title:"Overview", objectList: overViewList))
            {
                expenseList
                incomeList
            }
        }
    }
    
    
    
    var expenseList: some View {
        List {
            ScrollView {
                Text("Expenses").font(.title3).fontWeight(.bold)
                ForEach(overViewList.expenses) { expense in
                    NavigationLink(value: expense) {
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
    
    var incomeList: some View {
        List {
            ScrollView {
                Text("Income").font(.title3).fontWeight(.bold)
                ForEach(overViewList.incomes) { income in
                    NavigationLink(value: income.id) {
                        VStack (alignment: .leading) {
                            Text(income.title).font(.headline).fontWeight(.bold)
                            HStack{
                                Text("€ +\(income.amount, specifier: "%.2f")")
                                Spacer()
                                Text("\(income.createdAt.formatted(.dateTime.day().month().year()))")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OverViewListView(overViewList: OverViewList())
}
