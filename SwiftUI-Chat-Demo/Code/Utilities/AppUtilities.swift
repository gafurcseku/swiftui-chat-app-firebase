//
//  AppUtilities.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation
import FirebaseAuth

/// Utility class for commonly used app functions.
struct AppUtilities {
    
    /// Retrieves the current user's Firebase authentication ID (UID).
    /// - Returns: A string containing the user's UID if authenticated, or an empty string if no user is logged in.
    static func getFirebaseID() -> String {
        if let user = Auth.auth().currentUser {
            return user.uid
        } else {
            return ""
        }
    }
}

