//
//  User.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation

/// A struct representing a user in the system, conforming to `Codable` to support encoding and decoding.
/// This struct stores user-related information such as ID, status, name, profile photo, last message, and channel name.
struct User: Codable {
    let id: String?           // The unique ID of the user.
    let status: String?       // The current status of the user (e.g., active, offline).
    let created_at: Int?      // The creation timestamp of the user account (as an integer).
    let full_name: String?    // The full name of the user.
    let profile_photo: String? // URL or path to the user's profile photo.
    let last_message: String? // The last message sent or received by the user.
    let channel_name: String? // The name of the chat channel associated with the user.

    /// Coding keys used for encoding and decoding from JSON or other formats.
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case status = "status"
        case created_at = "created_at"
        case full_name = "full_name"
        case profile_photo = "profile_photo"
        case last_message = "last_message"
        case channel_name = "channel_name"
    }
    
    /// Initializes a `User` instance by decoding from a `Decoder`.
    /// - Parameter decoder: The decoder to extract data from.
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
    
    /// Custom initializer to create a `User` instance with optional parameters.
    init(id: String? = nil, status: String? = nil, created_at: Int? = nil, full_name: String? = nil, profile_photo: String? = nil, last_message: String? = nil, channel_name: String? = nil) {
        self.id = id
        self.status = status
        self.created_at = created_at
        self.full_name = full_name
        self.profile_photo = profile_photo
        self.last_message = last_message
        self.channel_name = channel_name
    }
}

/// An extension for the `User` struct providing computed properties for safely accessing optional fields.
extension User {
    
    /// Returns the user's ID, or an empty string if `id` is `nil`.
    var getID: String {
        return id ?? ""
    }
    
    /// Returns the user's status, or "N/A" if `status` is `nil`.
    var getStatus: String {
        return status ?? "N/A"
    }
    
    /// Returns the user's full name, or "N/A" if `full_name` is `nil`.
    var getFullName: String {
        return full_name ?? "N/A"
    }
    
    /// Returns the user's profile photo URL, or "N/A" if `profile_photo` is `nil`.
    var getProfilePhoto: String {
        return profile_photo ?? "N/A"
    }
    
    /// Returns the user's last message, or "N/A" if `last_message` is `nil`.
    var getLastMessage: String {
        return last_message ?? "N/A"
    }
}

