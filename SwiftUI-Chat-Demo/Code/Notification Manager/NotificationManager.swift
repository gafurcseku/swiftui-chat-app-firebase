//
//  NotificationManager.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation
import UserNotifications

@MainActor
class NotificationManager : ObservableObject {
    @Published private(set) var hasPermission = false
    
    init() {
        Task {
            await getAuthStatus()
        }
    }
    
    func requestNotificationAuth() async {
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            print(error)
        }
    }
    
    func getAuthStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings()
        
        switch status.authorizationStatus {
        case .authorized, .ephemeral, .provisional:
            hasPermission = true
        default:
            hasPermission = false
        }
    }
}
