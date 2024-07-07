//
//  AddReceiptToExpenseConfirmationView.swift
//  AIExpenseTracker
//
//  Created by Alfian Losari on 07/07/24.
//

import SwiftUI

struct AddReceiptToExpenseConfirmationView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State var vm: AddReceiptToExpenseConfirmationViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    HStack {
                        DatePicker(selection: $vm.date, displayedComponents: [.date]) {
                            Text("Date:")
                        }
                        
                        Spacer()
                        
                        HStack {
                            Picker(selection: $vm.currencyCode, label: Text("Currency:")) {
                                ForEach(Locale.commonISOCurrencyCodes, id: \.self) { iso in
                                    Text(iso).tag(iso)
                                }
                            }
                        }
                    }
                    
                    switch horizontalSizeClass {
                    case .regular: regularView
                    default: compactView
                    }
                }.listStyle(.plain)
            }
            .navigationTitle("Confirmation")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Confirm") {
                        vm.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .destructiveAction) {
                    Button("Reset Changes", role: .destructive) {
                        self.vm.resetChanges()
                    }
                    .tint(.red)
                    .disabled(!vm.isEdited)
                }
            }
        }
    }
    
    var regularView: some View {
        ForEach($vm.expenseLogs) { log in
            HStack(spacing: 16) {
                HStack {
                    Text("Name:")
                    nameTextField(log: log)
                }
                
                HStack {
                    Text("Amount:")
                    amountTextField(log: log)
                }
                
                HStack {
                    categoryPicker(log: log)
                    CategoryImageView(category: log.wrappedValue.categoryEnum)
                }
            }
        }
        .onDelete(perform: onDelete)
    }
    
    var compactView: some View {
        ForEach($vm.expenseLogs) { log in
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Name:")
                        .frame(maxWidth: 72, alignment: .leading)
                    Spacer()
                    nameTextField(log: log)
                }
                
                HStack {
                    Text("Amount:")
                        .frame(maxWidth: 72, alignment: .leading)
                    Spacer()
                    amountTextField(log: log)
                }
                
                HStack {
                    Text("Category")
                    Spacer()
                    categoryPicker(log: log)
                    CategoryImageView(category: log.wrappedValue.categoryEnum)
                }
            }
        }
        .onDelete(perform: onDelete)
        
    }
    
    
    func nameTextField(log: Binding<ExpenseLog>) -> some View {
        TextField(text: log.name, label: {Text("Name")})
            .lineLimit(2)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    func amountTextField(log: Binding<ExpenseLog>) -> some View {
        TextField("Amount", value: log.amount, formatter: vm.numberFormatter)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            #if !os(macOS)
            .keyboardType(.numbersAndPunctuation)
            #endif
    }
    
    func categoryPicker(log: Binding<ExpenseLog>) -> some View {
        Picker(selection: log.category, label: Text("Category:")) {
            ForEach(Category.allCases) { category in
                Text(category.rawValue.capitalized).tag(category.rawValue)
            }
        }
    }
    
    func onDelete(indexSet: IndexSet) {
        vm.expenseLogs.remove(atOffsets: indexSet)
    }
}

//#Preview {
//    AddReceiptToExpenseConfirmationView()
//}

