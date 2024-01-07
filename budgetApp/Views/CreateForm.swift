//
//  CreateForm.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 06/01/2024.
//

import SwiftUI

struct CreateForm: View {
    
    @ObservedObject var expenseList: ExpenseList
    @ObservedObject var incomeList: IncomeList
    
    //enum uit contentview.swift
    var transactionType: TransactionType
    
    @State var title: String = ""
    @State var  amount: Int = 0
    
    @FocusState var focus: Focused?
    @State var showValidationAlert = false
    @Environment(\.presentationMode) var presentationMode
    
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
        List{
            Section {
                TextField("Title", text: $title).focused($focus, equals: .title)
                CurrencyField(value: $amount, formatter: formatter)
                    .onTapGesture {
                        focus = .value
                    }.focused($focus, equals: .value)
            }
            Section {
                Button("Add") {
                    if !title.isEmpty && amount > 0 {
                        let amountInEuros = Float(amount) / 100
                        if transactionType == .expense {
                            Task {
                                    try await expenseList.add(title: title, amount: amountInEuros)
                                    presentationMode.wrappedValue.dismiss()
                            }
                        }
                        else {
                            Task{
                                try await incomeList.add(title: title, amount: amountInEuros)
                                presentationMode.wrappedValue.dismiss()

                            }
                        }
                    }
                    else{
                        showValidationAlert = true
                    }
                }.foregroundStyle(.blue)
            }
        }.onAppear {
            focus = .title
        }.font(.largeTitle)
            .navigationBarTitle("Add \(transactionType == .expense ? "expense" : "income")")
            .alert("Create",
                   isPresented: $showValidationAlert,
                   presenting: "Failed to create",
                   actions: { action in
                Button("ok", role: .cancel) { }
            },
                   message: { message in
                Text("Your title is empty and/or amount is less or equal to zero!")
            })
    }
}

#Preview {
    CreateForm(expenseList: ExpenseList(), incomeList: IncomeList(), transactionType: .expense)
}
