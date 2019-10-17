//
//  Movies.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class Movie: Decodable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    var backdropPath, originalLanguage, originalTitle: String?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(popularity: Double, voteCount: Int, video: Bool, posterPath: String, id: Int, adult: Bool, backdropPath: String, originalLanguage: String, originalTitle: String, title: String, voteAverage: Double, overview: String, releaseDate: String) {
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
    }
    
    init(realmMovie: RealmMovie) {
        self.popularity = realmMovie.popularity
        self.voteCount = realmMovie.voteCount
        self.video = realmMovie.video
        self.posterPath = realmMovie.posterPath
        self.id = realmMovie.id
        self.adult = realmMovie.adult
        self.backdropPath = realmMovie.backdropPath
        self.originalLanguage = realmMovie.originalLanguage
        self.originalTitle = realmMovie.originalTitle
        self.title = realmMovie.title
        self.voteAverage = realmMovie.voteAverage
        self.overview = realmMovie.overview
        self.releaseDate = realmMovie.releaseDate
    }
    
    init() {
        self.popularity = 0
        self.voteCount = 0
        self.video = false
        self.posterPath = ""
        self.id = -1
        self.adult = false
        self.backdropPath = ""
        self.originalLanguage = ""
        self.originalTitle = ""
        self.title = ""
        self.voteAverage = 0
        self.overview = ""
        self.releaseDate = ""
    }
}
