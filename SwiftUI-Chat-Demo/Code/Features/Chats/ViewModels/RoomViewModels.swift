//
//  RoomViewModels.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation
import SwiftUI

/// ViewModel class responsible for managing data related to a chat user in an application.
class RoomViewModels : BaseViewModel {
    
    /// Published property to hold the list of users in the chat .
    @Published var users: [User] = []
    
    /// Published property indicating whether there was a failure while fetching chat users data.
    @Published var chatRoomFail: Bool = false
    
    /// Property representing a single user.
    var person: User = .init()
    
    /// Function to fetch users belonging to the chat.
    func getRoomUser() {
        ChatUsersService().getUsers { result in
            switch result {
            case .success(let users):
                // Update users with animation
                withAnimation {
                    self.users = users
                }
            case .failure(_, _):
                // Set chatRoomFail flag to true in case of failure
                self.chatRoomFail = true
            }
        }
    }
}
