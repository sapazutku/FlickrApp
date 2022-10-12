//
//  Post.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import Foundation

struct Post: Codable {
    var photos: Photos
    let stat: String
}

struct Photos: Codable {
    let page, pages, perpage: Int
    let total: Int
    var photo: [PhotoElement]
}

struct PhotoElement: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

struct Size: Codable {
    let sizes: Sizes
    let stat: String
}

struct Sizes: Codable {
    let canblog, canprint, candownload: Int
    let size: [SizeElement]
}

struct SizeElement: Codable {
    let label: String
    let width, height: Int
    let source: String
    let url: String
    let media: String
}


