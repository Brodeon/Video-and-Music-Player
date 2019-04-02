//
//  MovieModel.swift
//  Video Player
//
//  Created by Przemek on 3/9/19.
//  Copyright © 2019 Przemek Broda. All rights reserved.
//

import Foundation

class MovieModel {

    func loadMovies() -> [Movie] {
        let url1 = Bundle.main.url(forResource: "fall", withExtension: "mov")
        print(url1?.absoluteString)
        
        let movies = [Movie(title: "Falls", url: url1!)]
        return movies
    }
}
