//
//  Messages.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation
import FirebaseFirestore

/// A struct representing a chat message, conforming to the `Codable` protocol to support encoding and decoding.
/// This struct is designed to handle messages with optional fields such as body, sender, channel name, chat type, and creation date.
struct Messages: Codable {
    let body: String?        // The body of the message.
    let sender: String?      // The sender of the message.
    let channel_name: String? // The name of the channel where the message was sent.
    let chat_type: String?   // The type of chat (e.g., group or direct).
    var createdAt: Date?     // The timestamp when the message was created.

    /// Coding keys for encoding and decoding the `Messages` struct to and from Firestore data.
    enum CodingKeys: String, CodingKey {
        case body = "body"
        case sender = "sender"
        case channel_name = "channel_name"
        case chat_type = "chat_type"
        case createdAt = "timestamp"  // The Firestore field storing the message creation timestamp.
    }

    /// Initializes the `Messages` struct by decoding from a `Decoder`, supporting Firestore's `Timestamp` type for dates.
    /// - Parameter decoder: The decoder used to read data and initialize the `Messages` struct.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        body = try values.decodeIfPresent(String.self, forKey: .body)
        sender = try values.decodeIfPresent(String.self, forKey: .sender)
        channel_name = try values.decodeIfPresent(String.self, forKey: .channel_name)
        chat_type = try values.decodeIfPresent(String.self, forKey: .chat_type)
        
        // Decoding the `createdAt` field from Firestore's `Timestamp` and converting it to `Date`.
        if let timestamp = try values.decodeIfPresent(Timestamp.self, forKey: .createdAt) {
            createdAt = timestamp.dateValue()
        } else {
            createdAt = nil
        }
    }
    
    /// Initializes a new `Messages` instance with optional values for body, sender, channel name, chat type, and creation date.
    init(body: String? = nil, sender: String? = nil, channel_name: String? = nil, chat_type: String? = nil, createdAt: Date? = nil) {
        self.body = body
        self.sender = sender
        self.channel_name = channel_name
        self.chat_type = chat_type
        self.createdAt = createdAt
    }
}

/// An extension for the `Messages` struct providing computed properties to access the message fields safely.
extension Messages {
    
    /// Returns the message body, or an empty string if the body is `nil`.
    var getBody: String {
        guard let body = self.body else { return "" }
        return body
    }
    
    /// Returns the sender's name, or an empty string if the sender is `nil`.
    var getSender: String {
        guard let sender = self.sender else { return "" }
        return sender
    }
    
    /// Returns the message creation date, or the current date if `createdAt` is `nil`.
    var getCreatedAt: Date {
        guard let createdAt = self.createdAt else { return Date() }
        return createdAt
    }
}

