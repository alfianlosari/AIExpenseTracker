//
//  LogListContainerView.swift
//  AIExpenseTracker
//
//  Created by Alfian Losari on 09/05/24.
//

import SwiftUI

struct LogListContainerView: View {
    
    @Binding var vm: LogListViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            FilterCategoriesView(selectedCategories: $vm.selectedCategories)
            Divider()
            SelectSortOrderView(sortType: $vm.sortType, sortOrder: $vm.sortOrder)
            Divider()
            LogListView(vm: $vm)
        }
        .toolbar {
            ToolbarItem {
                Button {
                    vm.isLogFormPresented = true
                } label: {
                    #if os(macOS)
                    HStack {
                        Image(systemName: "plus")
                            .symbolRenderingMode(.monochrome)
                            .tint(.accentColor)
                        Text("Add Expense Log")
                    }
                    .foregroundStyle(Color.accentColor)
                    #else
                    Text("Add")
                    #endif
                }

            }
            
        }
        .sheet(isPresented: $vm.isLogFormPresented) {
            LogFormView(vm: .init())
        }
        #if !os(macOS)
        .navigationBarTitle("XCA AI Expense Tracker", displayMode: .inline)
        #endif
    }
}

#Preview {
    @State var vm = LogListViewModel()
    return NavigationStack {
        LogListContainerView(vm: $vm)
    }
}
