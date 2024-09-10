//
//  DashBoardUIView.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// Represents the main dashboard view of the application.
struct DashBoardUIView: View {
    @StateObject var notificationManager = NotificationManager()
    var body: some View {
       
            // TabView containing different sections of the dashboard
            TabView {
                // HomeUIView for displaying home content
                HomeUIView()
                    .tabItem {
                        Label("Home", image: "home_bottom")
                    }
                
                // Placeholder for favorite section
                Text("Favorite")
                    .tabItem {
                        Label("", image: "favorite_bottom_icon")
                    }
                
                // Placeholder for person section
                SignOutView()
                    .tabItem {
                        Label("", image: "person_bottom_icon")
                    }
                
                // Placeholder for message section
                Text("Message")
                    .tabItem {
                        Label("", image: "message_bottom_icon")
                    }
                
                // Placeholder for more section
                Text("More")
                    .tabItem {
                        Label("", image: "more_bottom_icon")
                    }
            }
            // Set the accent color for the TabView
            .accentColor(Color.colorB42254)
        .onAppear(perform: {
            Task {
                await notificationManager.requestNotificationAuth()
            }
        })
    }
}

#Preview {
    DashBoardUIView()
}
