//
//  LogItemView.swift
//  AIExpenseTracker
//
//  Created by Alfian Losari on 09/05/24.
//

import SwiftUI

struct LogItemView: View {
    
    let log: ExpenseLog
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        switch horizontalSizeClass {
        case .compact: compactView
        default: regularView
        }
    }
    
    var compactView: some View {
        HStack(spacing: 16) {
            CategoryImageView(category: log.categoryEnum)
            VStack(alignment: .leading, spacing: 8) {
                Text(log.name).font(.headline)
                Text(log.dateText).font(.subheadline)
            }
            Spacer()
            Text(log.amountText).font(.headline)
        }
    }
    
    var regularView: some View {
        HStack(spacing: 16) {
            CategoryImageView(category: log.categoryEnum)
            Spacer()
            Text(log.name)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text(log.amountText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text(log.dateText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text(log.categoryEnum.rawValue)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}

#Preview {
    VStack {
        ForEach([
            ExpenseLog(id: "1", name: "sushi", category: "Food", amount: 10, date: .now),
            ExpenseLog(id: "2", name: "Electricity", category: "Utilities", amount: 50, date: .now)
                ]) { log in
            LogItemView(log: log)
        }
    }
    .padding()
}
