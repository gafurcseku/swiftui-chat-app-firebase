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

/// Singleton class to manage socket connections and message transmission.
class SocketClient {
    
    /// Shared singleton instance of `SocketClient`.
    private static var privateShared: SocketClient?
    
    /// Accessor for the singleton instance.
    class var shared: SocketClient {
        guard let shared = privateShared else {
            privateShared = SocketClient()
            return privateShared ?? SocketClient()
        }
        return shared
    }
    
    /// Instance of SocketIO client.
    var socket: SocketIOClient?
    
    /// Socket manager to control the connection.
    private var manager: SocketManager?
    
    /// Establishes a socket connection and notifies the caller via a completion handler.
    /// - Parameter complete: Closure that returns `true` if connection is successful, `false` otherwise.
    func socketConnection(complete: @escaping (Bool) -> Void) {
        if let socketURL = URL(string: Bundle.main.infoDictionary?["SocketUrl"] as? String ?? "") {
            manager = SocketManager(socketURL: socketURL, config: nil)
            socket = manager?.defaultSocket
            
            // Socket connection event handlers
            socket?.on(clientEvent: .connect) { (_, _) in
                complete(true)
            }
            socket?.on(clientEvent: .disconnect) { (_, _) in
                complete(false)
            }
            socket?.on(clientEvent: .error) { (data, _) in
                if let errorStr = data.first as? String, errorStr.hasPrefix("ERR_SOCKETIO_INVALID_SESSION") {
                    self.manager?.disconnect()
                    debugPrint("SocketClient: Error - \(errorStr)")
                }
            }
            
            // Initiate socket connection
            socket?.connect()
        } else {
            complete(false)
        }
    }
    
    /// Adds event listeners to a chat for real-time events. Assumes socket connection is already established.
    /// - Parameter completion: Closure for handling event listener responses.
    func addEventListeners(completion: @escaping ResponseHandler<Bool>) {
        if let socket = self.socket {
            socket.on("firestore_inserted") { data, _ in
                debugPrint("client => received event: \(data)")
                guard let firstItem = data.first else {
                    debugPrint("No data received")
                    completion(.failure("No data received", 404))
                    return
                }
                if let dict = firstItem as? [String: Any], dict["sender"] as? String != AppUtilities.getFirebaseID() {
                    self.triggerNotification(body: dict["body"] as? String ?? "")
                }
                completion(.success(true))
            }
        }
    }
    
    /// Triggers a local notification with the specified message body.
    /// - Parameter body: The message content to display in the notification.
    func triggerNotification(body: String) {
        let content = UNMutableNotificationContent()
        content.title = "New Message!"
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                debugPrint("Error adding notification: \(error)")
            } else {
                debugPrint("Notification sent!")
            }
        }
    }
    
    /// Sends a message to the server via the socket connection.
    /// - Parameter message: The message object to send.
    func sendMessage(message: Messages) {
        if let socket = self.socket, socket.status == .connected {
            let encoder = Firestore.Encoder()
            do {
                let encodedItem = try encoder.encode(message)
                print(encodedItem)
                socket.emitWithAck("insert_firestore", encodedItem).timingOut(after: 30) { data in
                    print(data)
                }
            } catch {
                print(error)
            }
        } else {
            print("SocketClient: Socket is not connected")
        }
    }
    
    /// Disconnects the socket manager.
    func disconnects() {
        manager?.disconnect()
    }
    
    /// Ensures the socket is disconnected when the `SocketClient` instance is deallocated.
    deinit {
        disconnects()
    }
}

