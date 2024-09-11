//
//  AppUtilities.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// A custom divider view that creates a thin horizontal line spanning the full width of its container.
/// - The divider has a maximum height of 0.5 points and no padding around it.
struct DividerView: View {
    var body: some View {
        Divider()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)  // Sets the width to full and the height to 0.5 points.
            .padding(.all, 0)                                                      // Removes any padding around the divider.
    }
}


#Preview {
    DividerView()
}
