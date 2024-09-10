import SwiftUI

public extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerModifier())
    }
}

public struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    let animation: Animation = Animation.linear(duration: 1.5).delay(0.5).repeatForever(autoreverses: false)

    public init() {}

    struct AnimatedModifier: AnimatableModifier {
        var phase: CGFloat = 0

        var animatableData: CGFloat {
            get { phase }
            set { phase = newValue }
        }

        func body(content: Content) -> some View {
            content
                .mask(GradientMask(phase: phase).scaleEffect(3))
        }
    }

    struct GradientMask: View {
        let phase: CGFloat
        let centerColor = Color.black.opacity(0.4)
        let edgeColor = Color.black

        var body: some View {
            LinearGradient(gradient:
                            Gradient(stops: [
                                .init(color: edgeColor, location: phase),
                                .init(color: centerColor, location: phase + 0.1),
                                .init(color: edgeColor, location: phase + 0.2),
                            ]), startPoint: .topLeading, endPoint: .trailing)
        }
    }

    public func body(content: Content) -> some View {
        content
            .modifier(
                AnimatedModifier(phase: phase).animation(animation)
            )
            .onAppear { phase = 0.8 }
    }
}

