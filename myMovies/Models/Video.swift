//
//  Video.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/16/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class Video: Decodable {
    let id, iso639_1, iso3166_1, key: String
    let name, site: String
    let size: Int
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
    
    init(id: String, iso639_1: String, iso3166_1: String, key: String, name: String, site: String, size: Int, type: String) {
        self.id = id
        self.iso639_1 = iso639_1
        self.iso3166_1 = iso3166_1
        self.key = key
        self.name = name
        self.site = site
        self.size = size
        self.type = type
    }
    
    init() {
        self.id = ""
        self.iso639_1 = ""
        self.iso3166_1 = ""
        self.key = ""
        self.name = ""
        self.site = ""
        self.size = 0
        self.type = ""
    }
}

