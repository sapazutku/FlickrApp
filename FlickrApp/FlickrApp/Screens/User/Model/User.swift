//
//  User.swift
//  FlickrApp
//
//  Created by utku on 15.10.2022.
//

import UIKit


class User {
    var username: String
    var email: String
    
    var likes: [String]?
    var saves: [String]?
    
    init(username: String,email: String, likes: [String]?, saves:[String]?) {
        self.username = username
        self.email = email
        
        self.likes = likes
        self.saves = saves
    }

}
