//
//  Shimmer.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 6/3/24.
//

import SwiftUI

public struct Shimmer {

    public struct Generic: View {
       

        public init() {}

        public var body: some View {
            Rectangle()
                .foregroundColor(Color.colorDDDDDD)
                .modifier(ShimmerModifier())
        }
    }

    public struct Card: View {
//        @EnvironmentObject var theme: GLTheme

        public init() {}

        public var body: some View {
            Rectangle()
                .foregroundColor(Color.colorDDDDDD)
                .modifier(ShimmerModifier())
                //.modifier(GLShapeViewModifier(shape: theme.shapes.cards.defaultCard))
        }
    }

    public struct Avatar: View {
        public enum Size: CGFloat {
            case xs = 24
            case sm = 32
            case md = 48
            case lg = 64
            case xl = 88
        }

       /// @EnvironmentObject var theme: GLTheme

        public var size: Size

        public init(size: Size) {
            self.size = size
        }

        public var body: some View {
            Circle()
                .frame(width: size.rawValue, height: size.rawValue)
                .foregroundColor(Color.colorDDDDDD)
                .modifier(ShimmerModifier())
               // .modifier(GLShapeViewModifier(shape: theme.shapes.cards.elevated))
        }
    }
}


#Preview {
    Shimmer.Generic()
   
}
