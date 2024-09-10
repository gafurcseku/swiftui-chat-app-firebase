//
//  ChatDetailsService.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//
import FirebaseFirestore

/// Service class responsible for fetching chat room history data from the API.
class ChatDetailsService : BaseService {
    
    /// Fetches chat room history for the specified chat ID.
    /// - Parameters:
    ///   - chatId: The ID of the chat room.
    ///   - completion: A closure to be executed when the history retrieval is completed. It takes a result of type `ResponseHandler<[Messages]>`, indicating success or failure.
    func getHistory(completion: @escaping ResponseHandler<[Messages]>) {
        db.collection("Messages").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error.localizedDescription, 404))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            do {
                let messages = try documents.compactMap { document -> Messages? in
                    return try document.data(as: Messages.self)
                }
                completion(.success(messages))
            } catch let error {
                completion(.failure(error.localizedDescription,404))
            }
        }
       
    }
    
    func sendMessage(message:Messages,completion: @escaping ResponseHandler<Bool>) {
        let encoder = Firestore.Encoder()
        do {
            var encodedItem = try encoder.encode(message)
            encodedItem["createdAt"] = FieldValue.serverTimestamp()
            try db.collection("Messages").addDocument(data: encodedItem) { error in
                if let error = error {
                    completion(.failure(error.localizedDescription, 404))
                }else {
                    completion(.success(true))
                }
            }
        } catch let error {
            completion(.failure(error.localizedDescription, 404))
        }
    }
}
