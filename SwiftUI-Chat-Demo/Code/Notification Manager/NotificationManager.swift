//
//  NotificationManager.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation
import UserNotifications

/// A class responsible for managing notification authorization and permission status.
/// This class is marked as `@MainActor` to ensure that all updates are performed on the main thread,
/// and it conforms to `ObservableObject` to allow SwiftUI views to react to changes in the permission status.
@MainActor
class NotificationManager: ObservableObject {
    
    /// A published property that tracks whether the user has granted notification permission.
    @Published private(set) var hasPermission = false
    
    /// Initializes the `NotificationManager` and checks the current notification authorization status.
    init() {
        Task {
            await getAuthStatus()  // Asynchronously fetch the current authorization status on initialization.
        }
    }
    
    /// Requests authorization for notifications with alert, sound, and badge options.
    /// This function is asynchronous and will handle any errors thrown during the request.
    func requestNotificationAuth() async {
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            print(error)  // Prints any errors encountered during the authorization request.
        }
    }
    
    /// Retrieves the current notification authorization status and updates the `hasPermission` property accordingly.
    /// This function checks if notifications are authorized, ephemeral, or provisional and updates the flag.
    func getAuthStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings()
        
        switch status.authorizationStatus {
        case .authorized, .ephemeral, .provisional:
            hasPermission = true  // Notifications are allowed.
        default:
            hasPermission = false  // Notifications are not allowed.
        }
    }
}

