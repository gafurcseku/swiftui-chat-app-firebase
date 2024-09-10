//
//  PersonRowView.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// Represents a row view for a person in a chat room.
struct PersonRowView: View {
    /// The user representing the person.
    var person: User
    /// A closure to handle completion actions such as blocking or reporting.
    var completion: (MenuType) -> ()
    
    var body: some View {
        VStack {
            HStack(spacing: 22) {
                // Displaying the profile photo of the person in a circle image
                RemoteImage.CircleImage(url: URL(string: person.getProfilePhoto))
                    .frame(width: 100, height: 100)
                    .contextMenu {
                        // Button to block the person
                        Button {
                            completion(MenuType.Block)
                        } label: {
                            Label("Block", image: "block_icon")
                        }
                        // Button to report the person
                        Button {
                            completion(MenuType.Report)
                        } label: {
                            Label("Report", image: "report_icon")
                        }
                    }
                
                VStack(alignment: .leading, spacing: 7) {
                    // Displaying the full name of the person
                    Text(person.getFullName)
                        .modifier(PTSansBoldTextModifier(fontSize: 22))
                        .foregroundColor(.black)
                    
                    // Displaying the last message sent by the person
                    Text(person.getLastMessage)
                        .modifier(PTSansRegularTextModifier(fontSize: 22))
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            // Adding a divider between rows
            DividerView()
        }
    }
}

/// Enum representing the type of menu options available.
public enum MenuType {
    case Report
    case Block
}

// Preview of the HomeUIView
#Preview {
    HomeUIView()
}
