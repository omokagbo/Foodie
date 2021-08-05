//
//  AppError.swift
//  Foodie
//
//  Created by EMMANUEL OMOKAGBO on 04/08/2021.
//

import Foundation

enum AppError: LocalizedError {
    
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "An unknown error occured"
        case .invalidUrl:
            return "Invalid url"
        case .serverError(let error):
            return "Server Error \(error)"
        }
    }
    
}
