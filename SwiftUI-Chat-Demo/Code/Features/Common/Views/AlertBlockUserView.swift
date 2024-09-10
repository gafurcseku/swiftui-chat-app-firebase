import SwiftUI

/// Represents a custom alert view for blocking a user.
struct AlertBlockUserView: View {
    /// Binding to control the visibility of the block alert.
    @Binding var blockAlert: Bool
    
    /// The user being blocked. Default is an empty user object.
    var person: User = User()
    
    var body: some View {
        // Custom alert view with options for blocking the user
        CustomAlert(showAlert: self.$blockAlert, positiveText: "BLOCK") {
            VStack(alignment: .leading, spacing: 15) {
                HStack(spacing: 10) {
                    Image("block_user_icon")
                    Text("Block User")
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
                
                // Description confirming the action of blocking the user
                Text("Are you sure you want to block this user? Once blocked they won’t be able to send you messages and won’t be able to match in future.")
                    .modifier(PTSansRegularTextModifier(fontSize: 16))
                    .foregroundColor(.black)
            }
        }
    }
}

// Preview of the AlertBlockUserView
#Preview {
    AlertBlockUserView(blockAlert: .constant(false))
}

