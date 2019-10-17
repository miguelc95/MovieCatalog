//
//  TV.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation


class TV: Codable {
    let originalName: String?
    let name: String?
    let popularity: Double?
    let voteCount: Int?
    let firstAirDate, backdropPath: String?
    let id: Int?
    let voteAverage: Double?
    let overview, posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case name, popularity
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
    
    init(originalName: String, name: String, popularity: Double, voteCount: Int, firstAirDate: String, backdropPath: String, id: Int, voteAverage: Double, overview: String, posterPath: String) {
        self.originalName = originalName
        self.name = name
        self.popularity = popularity
        self.voteCount = voteCount
        self.firstAirDate = firstAirDate
        self.backdropPath = backdropPath
        self.id = id
        self.voteAverage = voteAverage
        self.overview = overview
        self.posterPath = posterPath
    }
    
    init(realmTV: RealmTV) {
        self.originalName = realmTV.originalName
        self.name = realmTV.name
        self.popularity = realmTV.popularity
        self.voteCount = realmTV.voteCount
        self.firstAirDate = realmTV.firstAirDate
        self.backdropPath = realmTV.backdropPath
        self.id = realmTV.id
        self.voteAverage = realmTV.voteAverage
        self.overview = realmTV.overview
        self.posterPath = realmTV.posterPath
    }
}
