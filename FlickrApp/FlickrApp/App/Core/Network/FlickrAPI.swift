//
//  FlickrAPI.swift
//  FlickrApp
//
//  Created by utku on 12.10.2022.
//

import Moya
import Foundation

enum FlickrAPI{
    case getRecent
    case getSize(id: String)

}

extension FlickrAPI: TargetType{
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getRecent:
            return .requestParameters(parameters: ["method": "flickr.photos.getRecent", "api_key": "fc59ff43ff445e7f1e43e7602bb6b832","per_page": 10, "page": 1, "format": "json", "nojsoncallback": "1"], encoding: URLEncoding.queryString)
        case .getSize(let id):
            return .requestParameters(parameters: ["method": "flickr.photos.getSizes", "api_key": "fc59ff43ff445e7f1e43e7602bb6b832", "photo_id": id, "format": "json", "nojsoncallback": "1"], encoding: URLEncoding.queryString)

        }
            }
        var headers: [String : String]? {
            return nil
            
        }
        
        var baseURL: URL {
            guard let url = URL(string: "https://api.flickr.com/services/rest/") else {
                fatalError("baseURL is not in correct format")
            }
            return url
        }
        
        var path: String {
            switch self {
            case .getRecent:
                return ""
            case .getSize:
                return ""
            }

        }
        
}

