//
//  Movie.swift
//  Video Player
//
//  Created by Przemek on 3/9/19.
//  Copyright © 2019 Przemek Broda. All rights reserved.
//

import Foundation

class Movie {
    
    var title: String
    var url: URL
    
    init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
    
}
