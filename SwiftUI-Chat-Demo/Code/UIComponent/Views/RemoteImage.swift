//
//  AppUtilities.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// A struct that provides remote image loading functionality with different shapes (Circle and Rectangle).
public struct RemoteImage {
    
    /// A substructure that displays a remote image in a circular shape.
    public struct CircleImage: View {
        public var url = URL(string: "https://picsum.photos/200")  // Default image URL.
        
        /// Initializes the `CircleImage` view with an optional custom URL.
        /// - Parameter url: The URL of the image to display (default is a sample URL).
        public init(url: URL? = URL(string: "https://picsum.photos/200")) {
            self.url = url
        }
        
        /// The body of the view displaying the image loaded asynchronously, clipped into a circular shape.
        public var body: some View {
            AsyncImage(url: url, content: view)  // Loads the image asynchronously from the given URL.
                .clipShape(Circle())             // Clips the image into a circular shape.
        }
    }
    
    /// A substructure that displays a remote image in a rectangular shape.
    public struct RectangleImage: View {
        public var url = URL(string: "https://picsum.photos/200")  // Default image URL.
        
        /// Initializes the `RectangleImage` view with an optional custom URL.
        /// - Parameter url: The URL of the image to display (default is a sample URL).
        public init(url: URL? = URL(string: "https://picsum.photos/200")) {
            self.url = url
        }
        
        /// The body of the view displaying the image loaded asynchronously, clipped into a rectangular shape.
        public var body: some View {
            AsyncImage(url: url, content: view)  // Loads the image asynchronously from the given URL.
                .clipShape(Rectangle())          // Clips the image into a rectangular shape.
        }
    }
}


@ViewBuilder
private func view(for phase: AsyncImagePhase) -> some View {
       switch phase {
       case .empty:
           ProgressView()
       case .success(let image):
           image
               .resizable()
               .aspectRatio(contentMode: .fit)
       case .failure(_):
           VStack(spacing: 16) {
               Image(systemName: "xmark.octagon.fill")
                   .foregroundColor(.red)
           }
       @unknown default:
           Text("Unknown")
               .foregroundColor(.gray)
       }
   }

#Preview {
    RemoteImage.CircleImage()
}
