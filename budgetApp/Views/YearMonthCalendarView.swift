//
//  YearMonthView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 04/01/2024.
//

import SwiftUI

struct YearMonthCalendarView<T: ObservableObject>: View {
    @State var selection: Int = Int(Date().formatted(.dateTime.year())) ?? 0
    @State var monthSelection: String = Date().formatted(.dateTime.month(.abbreviated))
    @State var currentYear = Int(Date().formatted(.dateTime.year())) ?? 0
    @State var currentMonth = Date().formatted(.dateTime.month())
    @State var months = DateFormatter().shortMonthSymbols ?? []
    
    @StateObject var objectList: T
    
    var body: some View {
        HStack {
            Picker("", selection: $monthSelection) {
                ForEach(0 ..< months.count, id: \.self){ value in
                    Text(months[value]).tag(months[value])
                }
            }.onChange(of: monthSelection, {
                Task {
                    try await fetch()
                }
            })
            //SOURCE: https://stackoverflow.com/questions/64093723/swiftui-date-picker-display-year-only
            Picker("", selection: $selection) {
                ForEach(2023...currentYear, id: \.self) {
                    Text(String($0))
                }
            }.onChange(of: selection, {
                Task {
                    try await fetch()
                }
            })
        }.onAppear {
            Task {
                do {
                    try await fetch()
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func fetch() async throws{
        //kijken of object expense list is
        if objectList is ExpenseList {
            let expenseList = objectList as? ExpenseList
            try await expenseList?.fetchExpensesWithDate(year: selection, month: monthSelection)
        }
        //gaan er van uit dat het incomes zijn
        //TODO: aanpassen als er meer viewmodels zouden zijn
        else {
            let incomeList = objectList as? IncomeList
            try await incomeList?.fetchIncomesWithDate(year: selection, month: monthSelection)
        }
    }
}

#Preview {
    YearMonthCalendarView(objectList: ExpenseList())
}
