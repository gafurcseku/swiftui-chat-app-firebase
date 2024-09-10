//
//  SwiftUI_Chat_DemoApp.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AppDelegate : NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

extension AppDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcm = Messaging.messaging().fcmToken {
            print("FCM/Push message Token", fcm)
        }
    }
}

@main
struct SwiftUI_Chat_DemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            @State var coordinator = NavigationCoordinator()
            NavigationStack(path: $coordinator.paths) {
                if Auth.auth().currentUser != nil {
                    DashBoardUIView()
                }else{
                    LoginView()
                }
            }
            // inject object into environment so there is no need to pass to each view
            .environment(coordinator)
        }
    }
}
