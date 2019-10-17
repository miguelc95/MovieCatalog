//
//  VideoRequest.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/16/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation


class VideoRequest: Decodable {
    let id: Int
    let results: [Video]
    
    init(id: Int, results: [Video]) {
        self.id = id
        self.results = results
    }
}
