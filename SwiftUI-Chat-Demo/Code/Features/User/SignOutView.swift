//
//  SignOutView.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI
import FirebaseAuth

struct SignOutView: View {
    @State private var showingAlert = false
    @Environment(NavigationCoordinator.self) var coordinator: NavigationCoordinator
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Profile Image or Placeholder
            Image("person_bottom_icon")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding()

            // Welcome Text
            Text("Goodbye for now!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.horizontal)

            // Subtext
            Text("We hope to see you again soon.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
            
            // Sign Out Button
            Button(action: {
                showingAlert = true
            }) {
                Text("Sign Out")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Sign Out"),
                    message: Text("Are you sure you want to sign out?"),
                    primaryButton: .destructive(Text("Sign Out")) {
                        let firebaseAuth = Auth.auth()
                        do {
                          try firebaseAuth.signOut()
                              coordinator.popToRoot()
                        } catch let signOutError as NSError {
                          print("Error signing out: %@", signOutError)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [.white, .blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView()
    }
}

