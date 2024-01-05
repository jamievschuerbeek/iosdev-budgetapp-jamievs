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
            return templist!.getTotal
        }
        else {
            let templist = objectList as? ExpenseList
            return templist!.getTotal
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            HStack {
                Text("Total: € \(total, specifier: "%.2f")") //TODO: Deze aanpassen naar echt totaal
                Spacer()
                Menu("add", systemImage: "plus"){
                    Button("Add expense", systemImage: "eurosign") {
                        print("test1")
                    }
                    Button("Add income", systemImage: "eurosign.square"){
                        print("test2")
                    }
                }
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
