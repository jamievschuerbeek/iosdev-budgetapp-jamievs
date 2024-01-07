//
//  CreateForm.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 06/01/2024.
//

import SwiftUI

struct CreateForm: View {
    
    @ObservedObject var expenseList: ExpenseList
    
    @State var title: String = ""
    @State var  amount: Int = 0
    @FocusState var focus: Focused?
    
    enum Focused {
        case title
        case value
    }
    
    private var formatter: NumberFormatter{
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.minimumFractionDigits = 2
        fmt.maximumFractionDigits = 2
        fmt.locale = Locale(identifier: "nl_BE")
        return fmt
    }
    
    var body: some View {
            Form {
                Section {
                    TextField("Title", text: $title).focused($focus, equals: .title)
                    CurrencyField(value: $amount, formatter: formatter)
                        .onTapGesture {
                            focus = .value
                            print("test")
                        }.focused($focus, equals: .value)
                }
                Section {
                    Button("Add"){
                        print("submit")
                    }.foregroundStyle(.blue)
                }
            }.onAppear {
                focus = .title
            }.font(.largeTitle).navigationBarTitle("Add")
    }
}

#Preview {
    CreateForm(expenseList: ExpenseList())
}
