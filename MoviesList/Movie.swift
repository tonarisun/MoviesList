//
//  Movie.swift
//  MoviesList
//
//  Created by Olga Lidman on 10/09/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class Movie: Mappable {
    
    var nameRus = ""
    var name = ""
    var rating = 0.000
    var year = 0
    var imageURL = ""
    var description = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        nameRus <- map["localized_name"]
        name <- map["name"]
        rating <- map["rating"]
        year <- map["year"]
        imageURL <- map["image_url"]
        description <- map["description"]
    }
    
    static func < (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.rating < rhs.rating
    }
}

class MovieResponse: Mappable {
    
    var moviesList = [Movie]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        moviesList <- map["films"]
    }
}
