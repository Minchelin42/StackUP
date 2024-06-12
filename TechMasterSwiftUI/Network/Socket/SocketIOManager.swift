//
//  SocketIOManager.swift
//  TechMasterSwiftUI
//
//  Created by 민지은 on 2024/06/11.
//

import Foundation
import SocketIO
import Combine

final class SocketIOManager {
    
    static let shared = SocketIOManager()
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    let baseURL = URL(string: APIKey.baseURL.rawValue)!
    let roomID = "/chats-6667df0c488eb4cb431beb05" //chats-roomID
    
    var receivedChatData = PassthroughSubject<ChatResponseDTO, Never>()
    
    private init() {
        print("SocketIOManager Init")
        manager = SocketManager(socketURL: baseURL, config: [.log(true), .compress])
        
        socket = manager.socket(forNamespace: roomID)
        
        socket.on(clientEvent: .connect) { data, ack in
            print("socket connected", data, ack)
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("socket disconnected", data, ack)
        }
        
        socket.on("chat") { dataArray, ack in
            print("chat received", dataArray, ack)
            
            if let data = dataArray.first {
                let result = try? JSONSerialization.data(withJSONObject: data)
                let decodedData = try? JSONDecoder().decode(ChatResponseDTO.self, from: result!)
                
                self.receivedChatData.send(decodedData!)
            }
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func leaveConnection() {
        socket.disconnect()
    }
   
}
