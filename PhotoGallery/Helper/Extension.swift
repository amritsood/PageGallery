//
//  Extension.swift
//  PhotoGallery
//
//  Created by user on 11/03/22.
//

import Foundation
import UIKit
import SDWebImage

//MARK: UIViewController
extension UIViewController {
    
    /*
        This method will display simple alert with title and cancel option
     */
    func showAlert(_ title: String? = nil,
                   message: String? = nil) {
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Okay", style: .cancel)
        alertController.addAction(action)
        present(alertController, animated: false, completion: nil)
    }
}

//MARK: UIImageView
extension UIImageView {
    
    // common method to load image from url
    func loadImage(with urlString: String?) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: urlString ?? ""))
    }
}

//MARK: String
extension String {
    var isEmptyString: Bool {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
}
