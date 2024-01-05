//
//  IncomesView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 04/01/2024.
//

import SwiftUI

struct IncomesView: View {
    @ObservedObject var incomeList: IncomeList
    
    var body: some View {
        VStack {
            Section(header: SectionHeader(title:"Incomes", objectList: incomeList))
            {
                list
            }
        }
    }
    
    var list: some View {
        List {
            ForEach(incomeList.incomes) { income in
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

#Preview {
    IncomesView(incomeList: IncomeList())
}
