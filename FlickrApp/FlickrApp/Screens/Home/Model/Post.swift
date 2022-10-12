//
//  Post.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import Foundation

struct Post: Codable {
    let photos: Photos
    let stat: String
}

struct Photos: Codable {
    let page, pages, perpage: Int
    let total: Int
    let photo: [PhotoElement]
}

struct PhotoElement: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
