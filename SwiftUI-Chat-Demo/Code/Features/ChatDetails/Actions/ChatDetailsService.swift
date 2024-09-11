//
//  ChatDetailsService.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//
import FirebaseFirestore

/// Service class responsible for managing user chat history and sending messages to Firebase.
class ChatDetailsService: BaseService {
    
    /// Fetches the chat history for a specific chat  from the "Messages" collection in Firestore.
    /// - Parameters:
    ///   - completion: A closure that is called when the retrieval is complete.
    ///     It returns a `ResponseHandler<[Messages]>`, where the result is an array of `Messages` on success, or an error message on failure.
    func getHistory(completion: @escaping ResponseHandler<[Messages]>) {
        db.collection("Messages").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error.localizedDescription, 404))  // Returns an error if fetching documents fails.
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))  // Returns an empty array if no documents are found.
                return
            }
            do {
                let messages = try documents.compactMap { document -> Messages? in
                    print(document.data())  // Logs document data for debugging.
                    return try document.data(as: Messages.self)  // Decodes each document into a `Messages` object.
                }
                print(messages)  // Logs the retrieved messages for debugging.
                completion(.success(messages))  // Returns the list of messages on success.
            } catch let error {
                completion(.failure(error.localizedDescription, 404))  // Handles decoding errors and returns a failure.
            }
        }
    }
    
    /// Sends a message to the "Messages" collection in Firestore.
    /// - Parameters:
    ///   - message: The `Messages` object to be sent.
    ///   - completion: A closure that is called when the operation is complete.
    ///     It returns a `ResponseHandler<Bool>`, indicating success or failure.
    func sendMessage(message: Messages, completion: @escaping ResponseHandler<Bool>) {
        let encoder = Firestore.Encoder()
        do {
            var encodedItem = try encoder.encode(message)  // Encodes the message into Firestore format.
            encodedItem["createdAt"] = FieldValue.serverTimestamp()  // Adds a server-generated timestamp for `createdAt`.
            db.collection("Messages").addDocument(data: encodedItem) { error in
                if let error = error {
                    completion(.failure(error.localizedDescription, 404))  // Handles Firestore document addition errors.
                } else {
                    completion(.success(true))  // Indicates success when the message is successfully sent.
                }
            }
        } catch let error {
            completion(.failure(error.localizedDescription, 404))  // Handles encoding errors.
        }
    }
}

