//
//  RealmHandler.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/15/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHandler {
    public static func addRealmObject<T>(_ object: T) {
        try! uiRealm.write {
            uiRealm.add(object as! Object, update: Realm.UpdatePolicy.modified)
        }
    }
    
    public static func getRealmMovies(category: String.filmCategory, search: String, completionHandler: (_ movies: [Movie]) -> Void) {
        var predicate = "type == '\(category.rawValue)'"
        if search.count > 3 {
            predicate = "\(predicate) && title CONTAINS[cd] '\(search)'"
        }
        let realmMovieResult = uiRealm.objects(RealmMovie.self).filter(predicate).distinct(by: ["id"])
        var movies = [Movie]()
        movies = realmMovieResult.map({Movie(realmMovie: $0)})
        completionHandler(movies)
        
    }
    
    public static func getRealmSeries(category: String.seriesCategory, search: String, completionHandler: (_ movies: [TV]) -> Void) {
        var predicate = "type == '\(category.rawValue)'"
        if search.count > 3 {
            predicate = "\(predicate) && title CONTAINS[cd] '\(search)'"
        }
        let realmMovieResult = uiRealm.objects(RealmTV.self).filter(predicate).distinct(by: ["id"])
        var series = [TV]()
        series = realmMovieResult.map({TV(realmTV: $0)})
        completionHandler(series)
        
    }
}


