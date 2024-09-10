//
//  AppUtilities.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation
import FirebaseAuth

struct AppUtilities {
    
    static func getFirebaseID() -> String {
        if let user = Auth.auth().currentUser {
            return user.uid
        }else{
            return ""
        }
    }
}
