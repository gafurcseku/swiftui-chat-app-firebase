//
//  ChatUsersService.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation

/// Service class responsible for fetching chat room data from the API.
class ChatUsersService : BaseService {
    
    /// Function to retrieve the list of users in the chat rooms.
    /// - Parameter completion: Closure to handle the response containing either the list of users or an error.
    func getUsers(completion: @escaping ResponseHandler<[User]>) {
        db.collection("rooms").whereField("id", isNotEqualTo: AppUtilities.getFirebaseID()).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error.localizedDescription, 404))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            do {
                let users = try documents.compactMap { document -> User? in
                    return try document.data(as: User.self)
                }
                completion(.success(users))
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(error.localizedDescription,404))
            }
        }
    }
}
