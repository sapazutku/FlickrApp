//
//  Post.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import Foundation

struct Post: Decodable {
    var photos: Photos
    let stat: String
}

struct Photos: Decodable {
    let page, pages, perpage: Int
    let total: Int
    var photo: [PhotoElement]
}

struct PhotoElement: Decodable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let url: URL
}




