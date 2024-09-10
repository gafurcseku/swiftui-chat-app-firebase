import SwiftUI

/// Represents a view for displaying a message received from another user.
struct ReceiverRow: View {
    /// The text content of the message.
    var text: String = ""
    
    var body: some View {
        Text(text)
            .modifier(PTSansRegularTextModifier(fontSize: 18)) // Apply text modifier for consistent styling
            .modifier(Card()) // Apply card modifier for visual presentation
            .padding(.trailing, 80) // Add padding to align the message box to the left
    }
}

#Preview {
    ReceiverRow(text: "Hi John, Glad we matched. Your profile looks amazing! Looking forward to our date at Binge Bar DC - 506 H St NE LL, Washington, DC 20002 on Friday at 7:00 pm and getting to know you more :)")
}

