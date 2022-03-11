//
//  ServerError.swift
//  PhotoGallery
//
//  Created by user on 11/03/22.
//

import Foundation

enum ServerError: Error {
    
    case invalidUrl
    case serverError
    case parseError
    case custom(String)
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "Invalid url"
        case .serverError:
            return "Server not responding"
        case .custom(let description):
            return description
        case .parseError:
            return "Invailid response from server"
        }
    }
}
