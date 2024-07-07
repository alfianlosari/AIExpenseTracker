//
//  AddReceiptToExpenseConfirmationViewModel.swift
//  AIExpenseTracker
//
//  Created by Alfian Losari on 07/07/24.
//

import AIReceiptScanner
import Observation
import Foundation

@Observable
class AddReceiptToExpenseConfirmationViewModel {
    
    let db = DatabaseManager.shared
    let scanResult: SuccessScanResult
    let scanResultExpenseLogs: [ExpenseLog]
    
    var date: Date
    var currencyCode: String {
        willSet {
            self.numberFormatter.currencyCode = newValue
        }
    }
    var expenseLogs: [ExpenseLog]
    var isEdited: Bool {
        !(scanResult.receipt.date == date && expenseLogs == scanResultExpenseLogs)
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }()
    
    init(scanResult: SuccessScanResult) {
        self.scanResult = scanResult
        self.scanResultExpenseLogs = scanResult.receipt.expenseLogs
        self.expenseLogs = self.scanResultExpenseLogs
        self.date = scanResult.receipt.date ?? .now
        self.currencyCode = scanResult.receipt.currency ?? "USD"
        self.numberFormatter.currencyCode = self.currencyCode
    }
    
    func save() {
        expenseLogs.forEach { log in
            var _log = log
            _log.date = self.date
            _log.currency = self.currencyCode
            try? db.add(log: _log)
        }
    }
    
    func resetChanges() {
        self.expenseLogs = self.scanResultExpenseLogs
        self.date = scanResult.receipt.date ?? .now
        self.currencyCode = scanResult.receipt.currency ?? "USD"
    }
    
}

