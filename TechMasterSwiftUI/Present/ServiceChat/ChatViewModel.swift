//
//  ChatViewModel.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/06/11.
//

import Foundation
import Combine

final class ChatViewModel: ViewModelType {

    var cancellables = Set<AnyCancellable>()
    
    private var networkProvider = NetworkProvider()
    
    private var roomID = ""
    
    @Published
    var chat: String = ""
    
    @Published
    var messages: [ChatModel] = []
    
    var chatRepository: DataRepository

    var input = Input()

    @Published
    var output = Output()

    init(chatRepository: DataRepository = ChatRepository()) {
        self.chatRepository = chatRepository
        SocketIOManager.shared.receivedChatData
            .sink { chat in
                self.messages.append(chat.toDomain())
            }
            .store(in: &cancellables)
        transform()
    }
}

extension ChatViewModel {
 
    struct Input {
        var createChat = PassthroughSubject<Void, Never>()
        var loadChat = PassthroughSubject<String, Never>()
        var resultChatList = PassthroughSubject<ChatList, Never>()
        var sendMessage = PassthroughSubject<String, Never>()
    }
    
    struct Output {
    }
    
    enum Action {
        case createChat
        case sendMessage
    }
    
    func action(_ action: Action) {
        switch action {
        case .createChat:
            input.createChat.send(())
        case .sendMessage:
            input.sendMessage.send(self.chat)
        }
    }
    
    func transform() {
        
        input.createChat
            .sink { [weak self] _ in
                guard let self else { return }
                networkProvider.myAPICall(model: CreateChatResponseDTO.self, router: ChatRouter.createChat) { result in
                    self.roomID = result.roomID
                    SocketIOManager.shared.setSocket(self.roomID)
                    self.input.loadChat.send(self.roomID)
                    SocketIOManager.shared.establishConnection()
                }
            }
            .store(in: &cancellables)
        
        input.loadChat
            .sink { [weak self] roomID in
                guard let self else { return }
                chatRepository.router = ChatRouter.loadChatHistory(roomID: roomID)
                chatRepository.fetchData { chatList in
                    self.input.resultChatList.send(chatList)
                }
            }
            .store(in: &cancellables)
        
        input.resultChatList
            .sink { [weak self] chatList in
                guard let self else { return }
                for chat in chatList {
                    self.messages.append(chat.toDomain())
                }
            }
            .store(in: &cancellables)
        
        input.sendMessage
            .sink { [weak self] content in
                guard let self else { return }
                networkProvider.myAPICall(model: ChatResponseDTO.self, router: ChatRouter.sendMessage(roomID: self.roomID, query: SendModel(content: content))) { result in
                    self.chat = ""
                }
            }
            .store(in: &cancellables)
    }
    
    func isUser(_ senderID: String) -> Bool {
        if senderID != NowUser.userID {
            return false
        } else {
            return true
        }
    }
    

}

