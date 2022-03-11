//
//  Photo.swift
//  PhotoGallery
//
//  Created by user on 11/03/22.
//

import Foundation

//MARK: Photo Model

/*
 As I am not confident if the data would
 always be available so
 I am declaring all vairables as optional
 */

struct Photo: Decodable {
    let urls: PhotoUrl?
    let user: User?
    let description: String?
}

//MARK: User Model
struct User: Decodable {
    let name: String?
}

//MARK: Photo Url Model
struct PhotoUrl: Decodable {
    let regular: String?
}
