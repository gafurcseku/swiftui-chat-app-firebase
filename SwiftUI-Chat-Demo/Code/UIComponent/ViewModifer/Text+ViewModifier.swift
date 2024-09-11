//
//  AppUtilities.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// A view modifier that applies the 'PTSans-Regular' font style with a customizable font size and text alignment.
/// - Parameters:
///   - fontSize: The size of the font to apply (default is 16).
///   - textAlignment: The alignment of the text (default is `.leading`).
struct PTSansRegularTextModifier: ViewModifier {
    var fontSize: CGFloat = 16.0
    var textAlignment: TextAlignment = .leading

    func body(content: Content) -> some View {
        content
            .font(.PTSansRegular(ofSize: fontSize))         // Applies the 'PTSans-Regular' font with the specified size.
            .multilineTextAlignment(textAlignment)          // Aligns the text based on the provided text alignment.
    }
}

/// A view modifier that applies the 'PTSans-Bold' font style with a customizable font size.
/// - Parameter fontSize: The size of the font to apply (default is 22).
struct PTSansBoldTextModifier: ViewModifier {
    var fontSize: CGFloat = 22.0

    func body(content: Content) -> some View {
        content
            .font(.PTSansBold(ofSize: fontSize))           // Applies the 'PTSans-Bold' font with the specified size.
    }
}

