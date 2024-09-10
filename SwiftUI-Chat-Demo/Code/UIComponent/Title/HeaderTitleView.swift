import SwiftUI

/// A view representing a header title with optional back button functionality.
struct HeaderTitleView: View {
    /// Binding to the presentation mode environment variable for managing navigation.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    /// The text to display as the header title.
    var text: String = "Title"
    
    /// A boolean value indicating whether the back button should be enabled.
    var enableBack: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            // Header title text
            Text(text)
                .modifier(PTSansBoldTextModifier(fontSize: 35))
                .foregroundColor(.black)
                .padding()
                .onTapGesture {
                    // Dismiss the current view when tapped, if enableBack is true
                    if enableBack {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            // Divider line below the header title
            DividerView()
        }
    }
}

#Preview {
    // Example preview of HeaderTitleView with default settings
    HeaderTitleView()
}

