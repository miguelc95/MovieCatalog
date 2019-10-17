//
//  RealmMovieRequest.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/15/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmMovieRequest: Object {
    var movies = List<RealmMovie>()
    @objc dynamic var type: String = ""
    @objc dynamic var pkey: String = ""
    
    init(movies: List<RealmMovie>) {
        self.movies = movies
        self.type = ""
        self.pkey = "2344"
        super.init()
    }
    
    init(movieRequest: MoviesRequest, type: String.filmCategory) {
        let moviesAdded = List<RealmMovie>()
        if let incomingMovies = movieRequest.movies {
            for mov in incomingMovies {
                moviesAdded.append(RealmMovie(movie: mov, type: type))
            }
        }
        self.movies = moviesAdded
        self.type = type.rawValue
        self.pkey = "2344"
        super.init()
    }
    
     required init() {
        self.movies = List<RealmMovie>()
        self.type = ""
        self.pkey = "2344"

        super.init()
    }
    
     required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    override static func primaryKey() -> String? {
        return "pkey"
    }
}
