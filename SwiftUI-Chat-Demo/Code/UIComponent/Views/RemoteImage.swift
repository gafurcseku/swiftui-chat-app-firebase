//
//  RemoteImage.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 6/3/24.
//

import SwiftUI

public struct RemoteImage {
    
    public  struct CircleImage: View {
        public var url = URL(string: "https://picsum.photos/200")
        
        public init(url:URL? = URL(string: "https://picsum.photos/200")) {
            self.url = url
        }
        
        public var body: some View {
            AsyncImage(url: url,content: view)
                .clipShape(Circle())
        }
        
    }
    
    public  struct RectangleImage: View {
        public var url = URL(string: "https://picsum.photos/200")
        
        public init(url:URL? = URL(string: "https://picsum.photos/200")) {
            self.url = url
        }
        
        public var body: some View {
            AsyncImage(url: url,content: view)
                .clipShape(Rectangle())
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
