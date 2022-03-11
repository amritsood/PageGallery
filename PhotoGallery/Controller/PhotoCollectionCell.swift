//
//  PhotoCollectionCell.swift
//  PhotoGallery
//
//  Created by user on 11/03/22.
//

import UIKit
import SDWebImage

class PhotoCollectionCell: UICollectionViewCell {
    
    static let KCELL_IDENTIFIER = "\(PhotoCollectionCell.self)"
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var photo: Photo? = nil {
        didSet {
            self.configure()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.photoImageView.layer.cornerRadius = 6
        self.photoImageView.layer.masksToBounds = true
    }
    
    //MARK: Configure Cell
    private func configure() {
        guard let photo = self.photo else { return  }
        self.photoImageView.loadImage(with: photo.urls?.regular)
        self.lblUserName.text = photo.user?.name ?? ""
        self.lblDescription.text = photo.description ?? "Description is not available"
    }
}
