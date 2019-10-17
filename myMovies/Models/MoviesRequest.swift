//
//  MoviesRequest.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class MoviesRequest: Decodable {
    let movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
    init(movies: [Movie]) {

        self.movies = movies
    }
    
    init(realmMovieRequest: RealmMovieRequest) {
        self.movies = realmMovieRequest.movies.map({Movie(realmMovie:$0)})
    }
    
}
