//
//  User.swift
//  FlickrApp
//
//  Created by utku on 15.10.2022.
//

import Foundation


class User {
    var username: String
    var email: String
    var likes: [PhotoElement]
    var saves: [PhotoElement]
    
    init(username: String,email: String, likes: [PhotoElement], saves:[PhotoElement]) {
        self.username = username
        self.email = email
        self.likes = likes
        self.saves = saves
    }
}
