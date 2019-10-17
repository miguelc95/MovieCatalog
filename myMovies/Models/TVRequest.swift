//
//  TVRequest.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class TVRequest: Decodable {
    let series: [TV]?
    
    enum CodingKeys: String, CodingKey {
        case series = "results"
    }
    
    init( series: [TV]) {
        self.series = series
    }
}
