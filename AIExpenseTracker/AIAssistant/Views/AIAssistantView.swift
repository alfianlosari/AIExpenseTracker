//
//  AIAssistantView.swift
//  AIExpenseTracker
//
//  Created by Alfian Losari on 09/06/24.
//

import ChatGPTUI
import SwiftUI

let apiKey = "YOUR_API_KEY"
let _senderImage = "https://imagizer.imageshack.com/img923/732/0xV2bC.jpg"
let _botImage = "https://freepnglogo.com/images/all_img/1690998192chatgpt-logo-png.png"

enum ChatType: String, Identifiable, CaseIterable {
    case text = "Text"
    case voice = "Voice"
    var id: Self { self }
}

struct AIAssistantView: View {
    
    @State var textChatVM = AIAssistantTextChatViewModel(apiKey: apiKey)
    @State var voiceChatVM = AIAssistantVoiceChatViewModel(apiKey: apiKey)
    @State var chatType = ChatType.text
    
    var body: some View {
        VStack(spacing: 0) {
            Picker(selection: $chatType, label: Text("Chat Type").font(.system(size: 12, weight: .bold))) {
                ForEach(ChatType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            #if !os(iOS)
            .padding(.vertical)
            #endif
            
            Divider()
            
            ZStack {
                switch chatType {
                case .text:
                    TextChatView(customContentVM: textChatVM)
                case .voice:
                    VoiceChatView(customContentVM: voiceChatVM)
                }
            }.frame(maxWidth: 1024, alignment: .center)
        }
        #if !os(macOS)
        .navigationBarTitle("XCA AI Expense Assistant", displayMode: .inline)
        #endif
    }
}

#Preview {
    AIAssistantView()
}
