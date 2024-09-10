//
//  SocketClient.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation
import SocketIO

/// Singleton class responsible for managing socket connections and sending messages.
class SocketClient {
    
    /// Shared instance of SocketClient for singleton pattern.
    private static var privateShared: SocketClient?
    
    /// Singleton instance of SocketClient.
    class var shared: SocketClient {
        guard let shared = privateShared else {
            privateShared = SocketClient()
            return privateShared ?? SocketClient()
        }
        return shared
    }
    
    /// SocketIO client instance.
    var socket: SocketIOClient?
    
    /// Socket manager instance.
    private var manager: SocketManager?
    
    /// Establishes a socket connection and notifies the completion handler.
    /// - Parameter complete: A closure to be called when the connection is established.
    func socketConnection(complete: @escaping (Bool) -> Void) {
        if let socketURL = URL(string: Bundle.main.infoDictionary?["SocketUrl"] as? String  ?? "") {
            let config: SocketIOClientConfiguration = [.log(true), .compress,.connectParams(["EIO": "3"])]
            manager = SocketManager(socketURL: socketURL, config: config)
            socket = manager?.defaultSocket
            
            // Event handlers for socket events
            socket?.on(clientEvent: .connect) { (data, ack) in
                complete(true)
            }
            socket?.on(clientEvent: .disconnect) { (data, ack) in
                complete(false)
            }
            socket?.on(clientEvent: .error) { (data, ack) in
                if let errorStr = data.first as? String, errorStr.hasPrefix("ERR_SOCKETIO_INVALID_SESSION") {
                    self.manager?.disconnect()
                    print("SocketClient: Error - \(errorStr)")
                }
            }
            
            // Connect to the socket with payload (e.g., authentication token)
            socket?.connect(withPayload: ["token": Bundle.main.infoDictionary?["SocketToken"] as? String ?? ""])
        } else {
            complete(false)
        }
    }
    
    /// Adds event listeners to the specified chat room for receiving real-time events.
    /// - Parameter chatRoom: The identifier of the chat room to listen for events.
    /// - Note: This function assumes that the socket is already connected.
    func addEventListeners(chatId: String) {
        // Check if the socket is connected
        if let socket = self.socket, socket.status == .connected {
            // Add an event listener for the specified chat room
            socket.on(chatId) { data, _ in
                // Handle received event data (e.g., print or process data)
                print("client => received event: \(data)")
            }
        }
    }

    
    /// Sends a message to the specified chat room.
    /// - Parameters:
    ///   - chatRoom: The identifier of the chat room.
    ///   - message: The message to be sent.
    func sendMessage(chatRoom: String, message: String) {
        if let socket = self.socket, socket.status == .connected {
            let data = ["color": "#4D55F0", "row": "1", "col": "0", "namespace": "namespace_1"] as [String : Any]
            socket.emit("user-Selection", data)
            socket.emitWithAck(chatRoom, message).timingOut(after: 0) { data in
                // Handle acknowledgment data if necessary
            }
        } else {
            print("SocketClient: Socket is not connected")
        }
    }
    
    /// Disconnects the socket manager when the SocketClient is deallocated.
    deinit {
        if let manager = self.manager {
            manager.disconnect()
        }
    }
}
