//
//  BaseService.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import FirebaseFirestore

/// A base service class that provides access to the Firestore database.
/// This class can be inherited by other service classes to use the `Firestore` instance (`db`).
class BaseService {
    /// A shared Firestore instance to interact with the database.
    let db = Firestore.firestore()
}
