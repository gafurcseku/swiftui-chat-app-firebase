//
//  AppUtilities.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// A customizable alert view with options for positive and negative actions.
struct CustomAlert<Content>: View where Content: View {
    /// Binding to control the visibility of the alert.
    @Binding var showAlert: Bool
    
    /// Text for the negative action button.
    var negativeText: String = "CANCEL"
    
    /// Text for the positive action button.
    var positiveText: String = "OK"
    
    /// Content of the alert, typically containing the alert message and additional views.
    @ViewBuilder let content: Content
    
    /// Action to perform when the negative button is tapped.
    var negativeButtonAction: (() -> ())?
    
    /// Action to perform when the positive button is tapped.
    var positiveButtonAction: (() -> ())?
    
    var body: some View {
        ZStack {
            // Overlay to dim the background when the alert is presented
            Color.black.opacity(0.58)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.showAlert.toggle()
                }
            
            VStack(spacing: 0) {
                // Content of the alert
                content
                
                // Buttons for negative and positive actions
                HStack(spacing: 21) {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.showAlert.toggle()
                        }
                        negativeButtonAction?()
                    }) {
                        Text(negativeText)
                            .modifier(PTSansRegularTextModifier(fontSize: 16))
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        withAnimation {
                            self.showAlert.toggle()
                        }
                        positiveButtonAction?()
                    }) {
                        Text(positiveText)
                            .modifier(PTSansRegularTextModifier(fontSize: 16))
                            .foregroundColor(.red)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
            }
            .padding([.leading, .trailing], Padding.p25.rawValue)
            .padding(.top, Padding.p50.rawValue)
            .padding(.bottom, Padding.p25.rawValue)
            .background(Color.white)
            .padding([.leading, .trailing], 25)
        }
        .zIndex(2) // Ensure the alert is displayed above other views
    }
}
