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

// Enum defining the result types for API calls
//public enum Result<T> {
//    case success(T)
//    case failure(ErrorResponse)
//}

//typealias CompletionHandler<T> = (Result<T>) -> ()

// Type alias for response handler without headers
typealias ResponseHandler<T> = (Response<T>) -> ()
