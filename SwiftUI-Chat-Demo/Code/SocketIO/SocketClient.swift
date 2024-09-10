//
//  SocketClient.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation
import SocketIO
import FirebaseFirestore
import UIKit
import UserNotifications

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
            manager = SocketManager(socketURL: socketURL, config: nil)
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
                    debugPrint("SocketClient: Error - \(errorStr)")
                }
            }
            
            // Connect to the socket
            socket?.connect()
        } else {
            complete(false)
        }
    }
    
    /// Adds event listeners to the specified chat room for receiving real-time events.
    /// - Note: This function assumes that the socket is already connected.
    func addEventListeners(completion: @escaping ResponseHandler<Bool>) {
        // Check if the socket is connected
        if let socket = self.socket {
            // Add an event listener for the specified chat room
            socket.on("firestore_inserted") { data, _ in
                // Handle received event data (e.g., print or process data)
                debugPrint("client => received event: \(data)")
                guard let firstItem = data.first else {
                    debugPrint("No data received")
                    completion(.failure("No data received", 404))
                    return
                }
                if let dict = firstItem as? [String: Any] {
                    if(dict["sender"] as! String != AppUtilities.getFirebaseID()){
                        self.triggerNotification(body: dict["body"] as? String ?? "")
                    }
                    completion(.success(true))
                }
            }
        }
    }
    
    func triggerNotification(body:String) {
        let content = UNMutableNotificationContent()
        content.title = "New Message!"
        content.body = body
        content.sound = UNNotificationSound.default
        
        //  Create a trigger (here, no trigger because we want to send immediately)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        // Add the notification request
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                debugPrint("Error adding notification: \(error)")
            } else {
                debugPrint("Notification sent!")
            }
        }
    }
    
    /// Sends a message to the specified chat room.
    /// - Parameters:
    ///   - message: The message to be sent.
    func sendMessage(message:Messages) {
        if let socket = self.socket, socket.status == .connected {
            let encoder = Firestore.Encoder()
            do {
                let encodedItem = try encoder.encode(message)
                print(encodedItem)
                socket.emitWithAck("insert_firestore", encodedItem).timingOut(after: 30) { data in
                    // Handle acknowledgment data if necessary
                    print(data)
                }
            }catch let error {
                print(error)
            }
        } else {
            print("SocketClient: Socket is not connected")
        }
    }
    
    func disconnects() {
        if let manager = self.manager {
            manager.disconnect()
        }
    }
    
    /// Disconnects the socket manager when the SocketClient is deallocated.
    deinit {
        disconnects()
    }
}
