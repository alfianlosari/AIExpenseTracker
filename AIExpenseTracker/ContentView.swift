//
//  ContentView.swift
//  AIExpenseTracker
//
//  Created by Alfian Losari on 09/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var vm = LogListViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        #if os(macOS)
        splitView
        #elseif os(visionOS)
        tabView
        #else
        switch horizontalSizeClass {
        case .compact: tabView
        default: splitView
        }
        #endif
    }
    
    var tabView: some View {
        TabView {
            NavigationStack {
                LogListContainerView(vm: $vm)
            }
            .tabItem {
                Label("Expenses", systemImage: "tray")
            }.tag(0)
            
            NavigationStack {
                Text("AI Assistant")
            }
            .tabItem {
                Label("AI Assistant", systemImage: "waveform")
            }.tag(1)
        }
    }
    
    var splitView: some View {
        NavigationSplitView {
            List {
                NavigationLink(destination: LogListContainerView(vm: $vm)) {
                    Label("Expenses", systemImage: "tray")
                }
                
                NavigationLink(destination: Text("AI Assistant")) {
                    Label("AI Assistant", systemImage: "waveform")
                }
            }
        } detail: {
            LogListContainerView(vm: $vm)
        }
        .navigationTitle("XCA AI Expense Tracker")
    }
}

#Preview {
    ContentView()
}
