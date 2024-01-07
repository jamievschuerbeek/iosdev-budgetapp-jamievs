//
//  TransactionDetailsView.swift
//  budgetApp
//
//  Created by Jamie Van Schuerbeek on 07/01/2024.
//

import SwiftUI

struct TransactionDetailsView<T: Codable>: View {
    
    @Binding var transaction: T
    var income: IncomeModel.Income? {
        if transaction is IncomeModel.Income {
            print("Welkom welkom1")
            return transaction as? IncomeModel.Income
        }
        return nil
    }
    
    var expense: ExpenseModel.Expense? {
        if transaction is ExpenseModel.Expense {
            print("Welkom welkom")
            return transaction as? ExpenseModel.Expense
        }
        return nil
    }
    
    var body: some View {
        Form {
            if income != nil {
                detailItem("Id", contentText: Text("\(income!.id)").font(.system(size: 14)))
                detailItem("Tile", contentText: Text("\(income!.title)"))
                detailItem("amount", contentText: Text("€\(income!.amount, specifier: "%.2f")"))
                detailItem("date", contentText: Text("\(income!.createdAt.formatted(.dateTime))"))
            }
            else {
                detailItem("Id", contentText: Text("\(expense!.id)").font(.system(size: 14)))
                detailItem("Tile", contentText: Text("\(expense!.title)"))
                detailItem("amount", contentText: Text("€\(expense!.amount, specifier: "%.2f")"))
                detailItem("date", contentText: Text("\(expense!.createdAt.formatted(.dateTime))"))
            }
        }.navigationTitle("Details")
    }
    
    func detailItem(_ headerText: String, contentText: some View) -> some View {
        Section(header: Text(headerText)) {
            contentText
        }
    }
}

#Preview {
    TransactionDetailsView<IncomeModel.Income>(transaction: .constant(IncomeModel.Income(id: UUID(), title: "Test", amount: 10.20, createdAt: Date())))
}
