//
//  SectionHeader.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 04/01/2024.
//

import SwiftUI

struct SectionHeader<T: ObservableObject>: View {
    
    var title: String
    
    @StateObject var objectList: T
    var total: Float {
        if objectList is ExpenseList {
            let templist = objectList as? ExpenseList
            return -templist!.getTotal
        }
        else if objectList is OverViewList {
            let templist = objectList as? OverViewList
            return templist!.getTotal
        }
        else {
            let templist = objectList as? IncomeList
            return templist!.getTotal
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            HStack {
                Text("Total:")
                Text("€\(total, specifier: "%.2f")").foregroundStyle(total < 0 ? .red : .green)
            }
            YearMonthCalendarView(objectList: objectList)
        }.padding()
            .frame(
                maxWidth: .infinity,
                alignment: .leading)
    }
}

#Preview {
    SectionHeader(title:"test", objectList: ExpenseList())
}
