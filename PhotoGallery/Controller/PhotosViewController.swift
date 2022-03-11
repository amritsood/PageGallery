//
//  PhotosViewController.swift
//  PhotoGallery
//
//  Created by user on 11/03/22.
//

import UIKit

/*
 Photo Gallery Controller
 Responsible to show all photos with 2 options
 - list view
 - grid view
 */

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!

    var isSearching: Bool = false {
        didSet {
            self.photosCollectionView.reloadData()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.isLoading ? indicatorView.startAnimating() : indicatorView.stopAnimating()
        }
    }
    
    var layout: PageLayout = .grid {
        willSet {
            self.photosCollectionView.collectionViewLayout.invalidateLayout()
        } didSet {
            self.updateLayout()
        }
    }
    
    private var photos: [Photo] = [] {
        didSet {
            self.photosCollectionView.reloadData()
        }
    }
    
    private var searchResults: [Photo] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupScreen()
        self.fetchPhotos()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateLayout()
    }
}

//MARK: Configure
private extension PhotosViewController {
    
    func setupScreen() {
        self.title = StringConstants.KPHOTO_GALLERY
        self.indicatorView.hidesWhenStopped = true
        self.setupNavBarButton()
    }
    
    // setup right top bar button
    func setupNavBarButton() {
        let barButton = UIBarButtonItem(image: layout.barImage,
                                        style: .plain,
                                        target: self,
                                        action: #selector(addTapped))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func addTapped(_ sender: UIBarButtonItem) {
        self.layout =  layout == .list ? .grid : .list
        sender.image = layout.barImage
    }
    
    // updates collection view layout
    func updateLayout() {
        
        let isGridLayout = layout == .grid
        let collectionViewLayout = photosCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let spacing = 10
        let numberOfItems = isGridLayout ? 2 : 1
        let totalSpacing = (numberOfItems + 1) * spacing
        let width = isGridLayout ? ((photosCollectionView.bounds.width - CGFloat(totalSpacing)) / 2) :  photosCollectionView.bounds.width - CGFloat(totalSpacing)
        let height : CGFloat = 300
        collectionViewLayout?.itemSize = CGSize.init(width: width, height: height)
        collectionViewLayout?.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewLayout?.minimumLineSpacing = 10
        collectionViewLayout?.minimumInteritemSpacing = 10
    }
    
    // displays photo in image viewer
    func viewPhoto(_ photo: Photo) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewerViewController") as?  ImageViewerViewController else {
            // no controller with this identifer
            return
        }
        controller.photo = photo
        self.present(controller, animated: true, completion: nil)
    }
}

//MARK: UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? searchResults.count : photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.KCELL_IDENTIFIER, for: indexPath) as! PhotoCollectionCell
        cell.photo = isSearching ? searchResults[indexPath.row] : photos[indexPath.row]
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = isSearching ? searchResults[indexPath.row] : photos[indexPath.row]
        self.viewPhoto(photo)
    }
}

//MARK: UISearchBarDelegate
extension PhotosViewController: UISearchBarDelegate {
    
    /*
     User can search image based on user's name
     */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /*
         As of now we have only 8 or 10 records so I am filtering out the results in this method only
         if there will be huge data then we can use background threads and update the results in main thread
         */
        guard let text = searchBar.text else { return }
        self.searchResults = self.photos.filter{ $0.user?.name?.contains(text) ?? false }
        self.isSearching = !text.isEmptyString
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK: API Calls
extension PhotosViewController {
    
    func fetchPhotos() {
        
        self.isLoading = true
        NetworkManager.shared.getRequest([Photo].self,
                                         with: .photos) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.photos = response
                case .failure(let error):
                    self.showAlert(StringConstants.KERROR, message: error.description)
                }
            }
        }
    }
}
