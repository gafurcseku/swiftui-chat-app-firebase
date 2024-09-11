//
//  AppUtilities.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// Extension on `View` to add a shimmer effect using a custom view modifier.
/// - Returns: A view with a shimmer animation applied.
public extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerModifier())
    }
}

/// A custom view modifier that applies a shimmer effect to any view.
/// The shimmer is created using a moving gradient mask.
public struct ShimmerModifier: ViewModifier {
    
    /// Animation phase value to control the shimmer movement.
    @State private var phase: CGFloat = 0
    
    /// Shimmer animation configuration: linear, non-reversing, infinite.
    let animation: Animation = Animation.linear(duration: 1.5).delay(0.5).repeatForever(autoreverses: false)

    /// Public initializer.
    public init() {}

    /// Nested struct responsible for animating the shimmer effect.
    struct AnimatedModifier: AnimatableModifier {
        var phase: CGFloat = 0

        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }

        /// Applies the gradient mask to the content for shimmer effect.
        func body(content: Content) -> some View {
            content
                .mask(GradientMask(phase: phase).scaleEffect(3))
        }
    }

    /// Nested struct to define the gradient mask used for the shimmer effect.
    struct GradientMask: View {
        let phase: CGFloat
        let centerColor = Color.black.opacity(0.4)  // Lighter part of the gradient
        let edgeColor = Color.black  // Darker part of the gradient

        var body: some View {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: edgeColor, location: phase),
                    .init(color: centerColor, location: phase + 0.1),
                    .init(color: edgeColor, location: phase + 0.2),
                ]),
                startPoint: .topLeading, endPoint: .trailing
            )
        }
    }

    /// Applies the shimmer effect to the view using the `AnimatedModifier` and starts the animation.
    public func body(content: Content) -> some View {
        content
            .modifier(
                AnimatedModifier(phase: phase).animation(animation)
            )
            .onAppear { phase = 0.8 }  // Starts the shimmer animation when the view appears.
    }
}


