//
//  Messages.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation
import FirebaseFirestore

struct Messages : Codable {
    let body : String?
    let sender : String?
    let channel_name : String?
    let chat_type : String?
    var createdAt: Date?

    enum CodingKeys: String, CodingKey {

        case body = "body"
        case sender = "sender"
        case channel_name = "channel_name"
        case chat_type = "chat_type"
        case createdAt = "timestamp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        body = try values.decodeIfPresent(String.self, forKey: .body)
        sender = try values.decodeIfPresent(String.self, forKey: .sender)
        channel_name = try values.decodeIfPresent(String.self, forKey: .channel_name)
        chat_type = try values.decodeIfPresent(String.self, forKey: .chat_type)
        if let timestamp = try values.decodeIfPresent(Timestamp.self, forKey: .createdAt) {
                    createdAt = timestamp.dateValue()
                } else {
                    createdAt = nil
                }
    }
    
    init(body: String? = nil, sender: String? = nil, channel_name: String? = nil, chat_type: String? = nil, createdAt:Date? = nil) {
        self.body = body
        self.sender = sender
        self.channel_name = channel_name
        self.chat_type = chat_type
        self.createdAt = createdAt
    }

}

extension Messages {
    
    var getBody:String {
        guard let body = self.body else { return "" }
        return body
    }
    
    var getSender:String {
        guard let sender = self.sender else { return "" }
        return sender
    }
    
    var getCreatedAt:Date {
        guard let createdAt = self.createdAt else { return Date() }
        return createdAt
    }
    
}
