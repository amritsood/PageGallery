//
//  PageLayout.swift
//  PhotoGallery
//
//  Created by user on 11/03/22.
//

import Foundation
import UIKit

enum PageLayout {
    
    case grid
    case list
    
    var barImage: UIImage? {
        switch self {
        case .list:
            return UIImage(named: "PhotoGrid")
        case .grid:
            return UIImage(named: "PhotoList")
        }
    }
}
