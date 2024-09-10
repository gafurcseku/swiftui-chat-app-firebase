import SwiftUI

/// A customizable checkbox view with associated content.
struct CheckBoxView<Content>: View where Content: View {
    /// Binding to track the checkbox state (checked or unchecked).
    @Binding var checked: Bool
    
    /// The content to display alongside the checkbox.
    @ViewBuilder let content: Content
    
    var body: some View {
        HStack(spacing: 21) {
            // Checkbox icon based on the checked state
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .renderingMode(.template)
                .frame(width: 18, height: 18)
                .foregroundColor(checked ? Color.red : Color.black)
                .onTapGesture {
                    // Toggle the checkbox state when tapped
                    self.checked.toggle()
                }
            
            // Display the associated content
            content
            
            // Spacer to push content to the leading edge
            Spacer()
        }
    }
}

#Preview {
    // Example preview of CheckBoxView with a checked state and associated text content
    CheckBoxView(checked: .constant(true)) {
        Text("Example Checkbox")
    }
}

