//
//  AppUtilities.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// A view modifier that adds a white background and padding to a view.
struct SurfaceBackGround: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)  // Adds a white background to the view
            .padding()                 // Adds default padding around the view
    }
}

/// A view modifier that adds customizable padding, a semi-transparent background, and rounded corners to create a card-like appearance.
struct Card: ViewModifier {
    var padding: CGFloat = 25  // The amount of padding to apply around the content
    
    func body(content: Content) -> some View {
        content
            .padding(padding)                                   // Adds specified padding around the content
            .background((Color.colorDDDDDD).opacity(0.5))        // Adds a semi-transparent background with custom color
            .cornerRadius(20)                                   // Rounds the corners of the background
    }
}


#Preview("Card") {
    VStack{
       Text("Hi Jenny, Glad we matched. Your profile looks amazing! Looking forward to our date at NORTH END coffee roasters Banani - Borak Mehnur")
            .frame(width: 300, height: 300)
    }
    .modifier(Card())
}

#Preview("Bg") {
    VStack{
       Text("Hi Jenny, Glad we matched. Your profile looks amazing! Looking forward to our date at NORTH END coffee roasters Banani - Borak Mehnur")
            .frame(width: 300, height: 300)
    }
    .modifier(SurfaceBackGround())
}
