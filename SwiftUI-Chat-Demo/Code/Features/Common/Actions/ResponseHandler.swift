//
//  ResponseHandler.swift
//  SwiftUI-Chat-Demo
//
//  Created by Md Abdul Gafur on 10/9/24.
//

import Foundation

// Enum defining the response types for API calls
public enum Response<T> {
    case success(T)
    case failure(String, Int)
}

// Type alias for response handler without headers
typealias ResponseHandler<T> = (Response<T>) -> ()
