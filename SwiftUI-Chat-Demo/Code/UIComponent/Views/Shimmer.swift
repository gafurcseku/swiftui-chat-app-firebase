//
//  AppUtilities.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// A struct that provides various views with a shimmer effect.
/// It contains multiple subviews (`Generic`, `Card`, and `Avatar`), each with a specific shape and appearance.
public struct Shimmer {
    
    /// A generic shimmer view that displays a rectangular placeholder with a shimmer effect.
    public struct Generic: View {

        /// Initializes a generic shimmer view.
        public init() {}

        /// The body of the view, which is a rectangle with a shimmer effect applied.
        public var body: some View {
            Rectangle()
                .foregroundColor(Color.colorDDDDDD)    // Applies a light gray background color to the rectangle.
                .modifier(ShimmerModifier())           // Applies the shimmer effect modifier.
        }
    }

    /// A card-shaped shimmer view that displays a rectangular card with a shimmer effect.
    public struct Card: View {
        // @EnvironmentObject var theme: GLTheme  // Commented out, potentially for theming purposes.
        
        /// Initializes a card-shaped shimmer view.
        public init() {}

        /// The body of the view, which is a rectangle styled as a card with a shimmer effect.
        public var body: some View {
            Rectangle()
                .foregroundColor(Color.colorDDDDDD)    // Applies a light gray background color to the card.
                .modifier(ShimmerModifier())           // Applies the shimmer effect modifier.
                // .modifier(GLShapeViewModifier(shape: theme.shapes.cards.defaultCard)) // Custom shape modifier (commented out).
        }
    }

    /// An avatar-shaped shimmer view that displays a circular placeholder with various size options and a shimmer effect.
    public struct Avatar: View {
        
        /// Enumeration defining the various sizes of the avatar.
        public enum Size: CGFloat {
            case xs = 24  // Extra small avatar (24x24)
            case sm = 32  // Small avatar (32x32)
            case md = 48  // Medium avatar (48x48)
            case lg = 64  // Large avatar (64x64)
            case xl = 88  // Extra large avatar (88x88)
        }

        // @EnvironmentObject var theme: GLTheme  // Commented out, potentially for theming purposes.
        
        /// The size of the avatar, defined by the `Size` enum.
        public var size: Size

        /// Initializes the avatar shimmer view with the specified size.
        /// - Parameter size: The size of the avatar to display.
        public init(size: Size) {
            self.size = size
        }

        /// The body of the view, which is a circle with a shimmer effect, sized based on the `Size` parameter.
        public var body: some View {
            Circle()
                .frame(width: size.rawValue, height: size.rawValue)  // Sets the size of the avatar based on the provided size.
                .foregroundColor(Color.colorDDDDDD)                  // Applies a light gray background color to the circle.
                .modifier(ShimmerModifier())                         // Applies the shimmer effect modifier.
                // .modifier(GLShapeViewModifier(shape: theme.shapes.cards.elevated)) // Custom shape modifier (commented out).
        }
    }
}



#Preview {
    Shimmer.Generic()
   
}
