//
//  BaseViewModel.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// Represents a custom alert view for reporting a user.
struct AlertReportUserView: View {
    /// Binding to control the visibility of the report alert.
    @Binding var reportAlert: Bool
    
    /// The user being reported. Default is an empty user object.
    var person: User = User()
    
    var body: some View {
        // Custom alert view with options for reporting the user
        CustomAlert(showAlert: self.$reportAlert, positiveText: "REPORT") {
            VStack(alignment: .leading, spacing: 15) {
                HStack(spacing: 10) {
                    Image("block_user_icon")
                    Text("Report User")
                        .modifier(PTSansBoldTextModifier(fontSize: 30))
                        .foregroundColor(.black)
                }
                HStack(spacing: 15) {
                    // Display user's profile photo and full name
                    RemoteImage.CircleImage(url: URL(string: person.getProfilePhoto))
                        .frame(width: 50, height: 50)
                    Text(person.getFullName)
                        .modifier(PTSansBoldTextModifier(fontSize: 22))
                        .foregroundColor(.black)
                }
                
                // Description and options for reporting the user
                Text("Please select your reasons for reporting this user. Once someone’s profile is reported we verify and take necessary measures against them.")
                    .modifier(PTSansRegularTextModifier(fontSize: 16))
                    .foregroundColor(.black)
                
                VStack(alignment: .leading) {
                    // Checkboxes for different reasons to report the user
                    CheckBoxView(checked: .constant(false)) {
                        Text("Impersonation")
                            .modifier(PTSansRegularTextModifier(fontSize: 16))
                            .foregroundColor(.black)
                    }
                    CheckBoxView(checked: .constant(false)) {
                        Text("Inappropriate Behavior")
                            .modifier(PTSansRegularTextModifier(fontSize: 16))
                            .foregroundColor(.black)
                    }
                    CheckBoxView(checked: .constant(false)) {
                        Text("Threats or Violence")
                            .modifier(PTSansRegularTextModifier(fontSize: 16))
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .modifier(Card(padding: 10)) // Apply card style to the checkboxes
                
            }
            .padding(.bottom, 25)
        }
    }
}

// Preview of the AlertReportUserView
#Preview {
    AlertReportUserView(reportAlert: .constant(false))
}

