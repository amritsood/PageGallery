//
//  ImageViewerViewController.swift
//  PhotoGallery
//
//  Created by user on 11/03/22.
//

import UIKit
import SDWebImage

/*
    Display image in large view
 */

class ImageViewerViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photo: Photo? = nil
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupScreen()
        self.loadImage()
    }
}

//MARK: Configure
private extension ImageViewerViewController {
    
    // setup default screen configuration
    func setupScreen() {
        self.view.backgroundColor = .black
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
    }
    
    // loads image in image view
    func loadImage() {
        guard let photo = self.photo else { return  }
        self.imageView.loadImage(with: photo.urls?.regular)
    }
}

//MARK: UIScrollViewDelegate
extension ImageViewerViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
