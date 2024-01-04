//
//  YearMonthView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 04/01/2024.
//

import SwiftUI

struct YearMonthCalendarView: View {
    @State var selection: Int = Int(Date().formatted(.dateTime.year())) ?? 0
    @State var monthSelection: String = Date().formatted(.dateTime.month(.abbreviated))
    @State var currentYear = Int(Date().formatted(.dateTime.year())) ?? 0
    @State var currentMonth = Date().formatted(.dateTime.month())
    @State var months = DateFormatter().shortMonthSymbols ?? []
    
    init(){
        print(months)
    }
    var body: some View {
        HStack {
            Picker("", selection: $monthSelection) {
                ForEach(0 ..< months.count, id: \.self){ value in
                    Text(months[value])
                }
            }
            //SOURCE: https://stackoverflow.com/questions/64093723/swiftui-date-picker-display-year-only
            Picker("", selection: $selection) {
                ForEach(2023...currentYear, id: \.self) {
                    Text(String($0))
                }
            }
        }
    }
}

#Preview {
    YearMonthCalendarView()
}
