//
//  RealmTV.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/16/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation
import RealmSwift
import Realm


class RealmTV: Object {
    @objc dynamic var originalName: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var popularity: Double = 0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var firstAirDate:String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var id: Int = -1
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var overview: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var type: String = ""


    convenience init(originalName: String, name: String, popularity: Double, voteCount: Int, firstAirDate: String, backdropPath: String, id: Int, voteAverage: Double, overview: String, posterPath: String, type: String) {
        self.init()
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
        self.type = type
        
    }
    
    convenience init(tv: TV, type: String.seriesCategory) {
        self.init()
        self.originalName = tv.originalName ?? ""
        self.name = tv.name ?? ""
        self.popularity = tv.popularity ?? 0
        self.voteCount = tv.voteCount ?? 0
        self.firstAirDate = tv.firstAirDate ?? ""
        self.backdropPath = tv.backdropPath ?? ""
        self.id = tv.id ?? -1
        self.voteAverage = tv.voteAverage ?? 0
        self.overview = tv.overview ?? ""
        self.posterPath = tv.posterPath ?? ""
        self.type = type.rawValue

    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
