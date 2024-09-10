import SwiftUI

/// Represents a view for displaying a message sent by the current user.
struct SenderRow: View {
    /// The text content of the message.
    var text: String
    
    var body: some View {
        Text(text)
            .modifier(PTSansRegularTextModifier(fontSize: 18)) // Apply text modifier for consistent styling
            .foregroundColor(.white) // Set text color to white
            .padding() // Add padding around the text
            .background(
                LinearGradient(gradient: Gradient(colors: [.colorB42254, .colorFF6FA0]), startPoint: .top, endPoint: .bottom) // Apply linear gradient background with colors
            )
            .cornerRadius(30) // Apply corner radius to create a rounded rectangle
            .padding(.leading, 80) // Add leading padding to align the message box to the right
    }
}

#Preview {
    SenderRow(text: "Excited for our date tomorrow :D")
}

