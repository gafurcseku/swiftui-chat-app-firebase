//
//  User.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation

struct User : Codable {
    let id : String?
    let status : String?
    let created_at : Int?
    let full_name : String?
    let profile_photo : String?
    let last_message : String?
    let channel_name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case status = "status"
        case created_at = "created_at"
        case full_name = "full_name"
        case profile_photo = "profile_photo"
        case last_message = "last_message"
        case channel_name = "channel_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(Int.self, forKey: .created_at)
        full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
        profile_photo = try values.decodeIfPresent(String.self, forKey: .profile_photo)
        last_message = try values.decodeIfPresent(String.self, forKey: .last_message)
        channel_name = try values.decodeIfPresent(String.self, forKey: .channel_name)
    }
    
    init(id: String? = nil, status: String? = nil, created_at: Int? = nil, full_name: String? = nil, profile_photo: String? = nil, last_message: String? = nil, channel_name : String? = nil) {
        self.id = id
        self.status = status
        self.created_at = created_at
        self.full_name = full_name
        self.profile_photo = profile_photo
        self.last_message = last_message
        self.channel_name = channel_name 
    }
    
    
}

extension User {
    var getID: String {
        guard let id = id else {
            return ""
        }
        return id
    }
        
    var getStatus: String {
        guard let status = status else {
            return "N/A"
        }
        return status
    }
        
    var getFullName: String {
        guard let fullName = full_name else {
            return "N/A"
        }
        return fullName
    }
    
    var getProfilePhoto: String {
        guard let profilePhoto = profile_photo else {
            return "N/A"
        }
        return profilePhoto
    }
    
    var getLastMessage: String {
        guard let lastMessage = last_message else {
            return "N/A"
        }
        return lastMessage
    }
}

