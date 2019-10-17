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

class RealmTVRequest: Object {
    var series = List<RealmTV>()
    @objc dynamic var type: String = ""
    @objc dynamic var pkey: String = ""
    
    init(series: List<RealmTV>) {
        self.series = series
        self.type = ""
        self.pkey = "2344"
        super.init()
    }
    
    init(tvRequest: TVRequest, type: String.seriesCategory) {
        let seriesAdded = List<RealmTV>()
        if let incomingSeries = tvRequest.series {
            for serie in incomingSeries {
                seriesAdded.append(RealmTV(tv: serie, type: type))
            }
        }
        self.series = seriesAdded
        self.type = type.rawValue
        self.pkey = "2344"
        super.init()
    }
    
    required init() {
        self.series = List<RealmTV>()
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
