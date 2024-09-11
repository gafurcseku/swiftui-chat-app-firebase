//
//  ChatDetailsViewModels.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI
import FirebaseFirestore

/// View model class for managing the details of a chat .
class ChatDetailsViewModels: BaseViewModel {
    /// Shared instance of SocketClient for handling socket connections.
    let socketIO = SocketClient.shared
    
    /// Published property holding the array of messages in the chat .
    @Published var messages: [Messages] = []
    
    /// Published property indicating whether fetching chat history failed.
    @Published var chatHistoryFail: Bool = false
    
    /// Published property indicating the status of the socket connection.
    @Published var isSocketConnected: Bool = false
    
    /// Fetches the chat history
    func getChatHistory() {
        ChatDetailsService().getHistory() { result in
            switch result {
            case .success(let messages):
                
                // Sorting messages by their date before assigning
                self.messages = messages.sorted(by: { message1, message2 in
                    message1.getCreatedAt < message2.getCreatedAt
                })
            case .failure(_, _):
                self.chatHistoryFail = true
            }
        }
    }
    
    // Sets up the socket connection.
    func setSocketConnection() {
        socketIO.socketConnection { isSuccess in
            self.isSocketConnected = isSuccess
        }
        socketIO.addEventListeners(){ result in
            switch result {
            case .success(let success):
                self.getChatHistory();
            case .failure(let message, let code): break
                
            }
        }
    }
    
    /// Sends a message to the specified chat .
    /// - Parameters:
    ///   - message: The message to be sent.
    func sendMessage(message: String) {
        let message = Messages(body: message,sender: AppUtilities.getFirebaseID(),channel_name: "test",chat_type: "text")
        socketIO.sendMessage(message: message)
        //        ChatDetailsService().sendMessage(message: message) { result in
        //            switch result {
        //            case .success(let success):
        //                self.getChatHistory();
        //            case .failure(let message, let code): break
        //
        //            }
        //        }
    }
}
