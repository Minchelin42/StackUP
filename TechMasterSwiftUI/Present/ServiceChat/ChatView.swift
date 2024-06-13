//
//  ChatView.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/06/11.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        VStack{
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(viewModel.messages, id:\.self) { chat in
                        ChatRow(content: chat.content, isUser: viewModel.isUser(chat.sender.userID))
                    }
                }
                .padding(10)
                .background(MyColor.white)
                .onChange(of: viewModel.messages) { _ in
                    if let lastMessage = viewModel.messages.last {
                        proxy.scrollTo(lastMessage, anchor: .bottom)
                    }
                }
            }
            
            HStack {
                chatTextField($viewModel.chat)
                sendButton(self.viewModel)
            }
            .frame(maxHeight: 50)
        }
        .task {  
            viewModel.action(.createChat)
        }
        .navigationTitle("고객센터")
    }
    
    private func sendButton(_ viewModel: ChatViewModel) -> some View {
        Image("send")
            .resizable()
            .frame(width: 20, height: 20)
            .wrapToButton {
                print("채팅 전송", viewModel.chat)
                viewModel.action(.sendMessage)
            }
            .frame(width: 40, height: 40)
            .background(MyColor.main)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func chatTextField(_ chat: Binding<String>) -> some View {
        TextField("채팅을 입력해주세요", text: chat)
            .font(.system(size: 13, weight: .medium))
            .foregroundStyle(MyColor.darkGray)
            .frame(width: 300, height: 40)
            .background(MyColor.white)
            .padding(.horizontal, 12)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(MyColor.main, lineWidth: 1))
    }
}

#Preview {
    ChatView()
}
