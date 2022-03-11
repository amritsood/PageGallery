//
//  URLPath.swift
//  PhotoGallery
//
//  Created by user on 11/03/22.
//

import Foundation

extension URL {
    
    static let serverUrl: String = "https://api.unsplash.com/"
    
    enum Path: String {
        
        case photos
        
        var url: URL? {
            return URL(string: URL.serverUrl + rawValue)
        }
    }
}
