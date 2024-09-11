//
//  AppUtilities.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import SwiftUI

/// Extension on `Font` providing custom font options.
public extension Font {
    /// Enum defining custom font name.
    enum CustomFont: String {
        case PTSansRegular = "PTSans-Regular"
        case PTSansBold = "PTSans-Bold"
    }
    
    /// Returns a custom font with the specified size from the PTSans Regular font family.
    /// - Parameter size: The size of the font.
    /// - Returns: A custom font instance with the specified size from the PTSans Regular font family.
    static func PTSansRegular(ofSize size: CGFloat) -> Font {
        .custom(CustomFont.PTSansRegular.rawValue, size: size)
    }
    
    /// Returns a custom font with the specified size from the PTSans Bold font family.
    /// - Parameter size: The size of the font.
    /// - Returns: A custom font instance with the specified size from the PTSans Bold font family.
    static func PTSansBold(ofSize size: CGFloat) -> Font {
        .custom(CustomFont.PTSansBold.rawValue, size: size)
    }
}

