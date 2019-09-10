//
//  AlamofireRequests.swift
//  MoviesList
//
//  Created by Olga Lidman on 10/09/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


class AlamofireRequests {
    
//    Получение списка фильмов с сервера
    func getMoviesList(completion: @escaping ([Movie]) -> Void) {
        let url = "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json"
        Alamofire.request(url).responseObject { (response: DataResponse<MovieResponse>) in
            guard let moviesResponse = response.result.value else { return }
            let moviesList = moviesResponse.moviesList
            completion(moviesList)
        }
    }
}
