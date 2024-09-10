//
//  HomeUIView.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI
import FirebaseAuth
// SwiftUI View struct for displaying a list of chat users and providing options to block or report users.
struct HomeUIView: View {
    // ViewModel to manage data and logic related to chat users
    @StateObject private var viewModel = RoomViewModels()
    // State variables to control alert presentation for blocking and reporting users
    @State var blockAlert = false
    @State var reportAlert = false
    
    var body: some View {
        ZStack {
            // Main content stack
            VStack(alignment: .leading) {
                // Custom header title view
                HeaderTitleView(text: "Chats", enableBack: false)
                // Display error message if loading chat users fails
                if(viewModel.chatRoomFail) {
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "xmark.icloud.fill")
                            .resizable().frame(width: 50, height: 50)
                        Text("Unable to load Chat Rooms")
                            .modifier(PTSansBoldTextModifier(fontSize: 22))
                        // Retry button to attempt loading chat users again
                        Button(action: { viewModel.getRoomUser() }) {
                            Text("Retry")
                                .modifier(PTSansBoldTextModifier(fontSize: 24))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                // Scroll view to display list of users
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0..<viewModel.users.count, id: \.self) { index in
                        let person = viewModel.users[index]
                        NavigationLink(destination: ChatDetailsView(person: person)) {
                        // Custom row view to display user information and actions
                        PersonRowView(person: person) { menuAction in
                            // Handling actions from the row view (e.g., blocking or reporting a user)
                            switch menuAction {
                            case .Block:
                                withAnimation(.easeInOut) {
                                    self.viewModel.person = person
                                    self.blockAlert.toggle()
                                }
                            case .Report:
                                withAnimation(.easeInOut) {
                                    self.viewModel.person = person
                                    self.reportAlert.toggle()
                                }
                            }
                        }
                    }
                    }
                }
                // Modifier to apply background styling
                .modifier(SurfaceBackGround())
                
                
                // Present block user alert if blockAlert is true
                if(self.blockAlert) {
                    withAnimation(.easeInOut) {
                        AlertBlockUserView(blockAlert: self.$blockAlert, person: self.viewModel.person)
                    }
                // Present report user alert if reportAlert is true
                } else if(self.reportAlert) {
                    withAnimation(.easeInOut) {
                        AlertReportUserView(reportAlert: self.$reportAlert, person: self.viewModel.person)
                    }
                }
            }
        }
        .zIndex(2)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.getRoomUser()
            let user = Auth.auth().currentUser
            if let user = user {
                print(user.uid)
            }
        }
    }
}

#Preview {
    HomeUIView()
}
