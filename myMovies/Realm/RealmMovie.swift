//
//  RealmMovie.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/15/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Realm
import RealmSwift
import Realm

class RealmMovie: Object {
    @objc dynamic var popularity: Double = 0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var video: Bool = false
    @objc dynamic var posterPath: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var overview:  String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var type: String = ""
    
    convenience init(popularity: Double, voteCount: Int, video: Bool, posterPath: String, id: Int, adult: Bool, backdropPath: String, originalLanguage: String, originalTitle: String, title: String, voteAverage: Double, overview: String, releaseDate: String, type: String) {
        self.init()
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.posterPath = posterPath
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
        self.type = type
    }
    
    convenience init(movie: Movie, type: String.filmCategory) {
        self.init()
        self.popularity = movie.popularity ?? 0
        self.voteCount = movie.voteCount ?? 0
        self.video = movie.video ?? false
        self.posterPath = movie.posterPath ?? ""
        self.id = movie.id ?? -1
        self.adult = movie.adult ?? false
        self.backdropPath = movie.backdropPath ?? ""
        self.originalLanguage = movie.originalLanguage ?? ""
        self.originalTitle = movie.originalTitle ?? ""
        self.title = movie.title ?? ""
        self.voteAverage = movie.voteAverage ?? 0
        self.overview = movie.overview ?? ""
        self.releaseDate = movie.releaseDate ?? ""
        self.type = type.rawValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
