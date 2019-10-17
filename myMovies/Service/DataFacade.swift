//
//  DataRetrievalFacade.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class DataFacade {
    static func getMovies(fileLocation: String, filmCategory: String.filmCategory, type: String.type, completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        if ConnectionStatus.shared.connected {
            Network.getExternalData(fileLocation: fileLocation) { (event: MoviesRequest?, error) in
                if let err = error {
                    completionHandler(nil,err)
                } else {
                    if let movieRequest = event {
                        let realmObject = RealmMovieRequest(movieRequest: movieRequest, type: filmCategory)
                        RealmHandler.addRealmObject(realmObject)
                    }
                    completionHandler(event?.movies,nil)
                }
                
            }
        } else {
                RealmHandler.getRealmMovies(category: filmCategory, search: "") { ( movies: [Movie])  in
                    completionHandler(movies,nil)
            }
        }
    }
    
    static func getMovie(fileLocation: String, id: Int, completionHandler: @escaping (Movie?, Error?) -> Void) {
        Network.getExternalData(fileLocation: fileLocation) { (event: Movie?, error) in
            if let err = error {
                completionHandler(nil,err)
            } else {
                if let movie = event {
                    let realmObject = RealmMovie(movie: movie, type: String.filmCategory.popular)
                    RealmHandler.addRealmObject(realmObject)
                }
                completionHandler(event,nil)
            }
        }
    }
    
    static func searchMovies(fileLocation: String, filmCategory: String.filmCategory, type: String.type, search: String, completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        if ConnectionStatus.shared.connected {
            Network.getExternalData(fileLocation: fileLocation) { (event: MoviesRequest?, error) in
                if let err = error {
                    completionHandler(nil,err)
                } else {
                    if let movieRequest = event {
                        let realmObject = RealmMovieRequest(movieRequest: movieRequest, type: filmCategory)
                        RealmHandler.addRealmObject(realmObject)
                    }
                    completionHandler(event?.movies,nil)
                }
                
            }
        } else {
                RealmHandler.getRealmMovies(category: filmCategory, search: search) { ( movies: [Movie])  in
                    completionHandler(movies,nil)
                }
        }
    }
    
    
    static func getSeries(fileLocation: String, seriesCategory: String.seriesCategory, type: String.type, completionHandler: @escaping ([TV]?, Error?) -> Void) {
        if ConnectionStatus.shared.connected {
            Network.getExternalData(fileLocation: fileLocation) { (event: TVRequest?, error) in
                if let err = error {
                    completionHandler(nil,err)
                } else {
                    if let tvRequest = event {
                        let realmObject = RealmTVRequest(tvRequest: tvRequest, type: seriesCategory)
                        RealmHandler.addRealmObject(realmObject)
                    }
                    completionHandler(event?.series,nil)
                }
                
            }
        } else {
            RealmHandler.getRealmSeries(category: seriesCategory, search: "") { (series: [TV]) in
                completionHandler(series,nil)
            }
        }
    }
    
    static func getSerie(fileLocation: String, id: Int, completionHandler: @escaping (TV?, Error?) -> Void) {
        Network.getExternalData(fileLocation: fileLocation) { (event: TV?, error) in
            if let err = error {
                completionHandler(nil,err)
            } else {
                if let tv = event {
                    let realmObject = RealmTV(tv: tv, type: String.seriesCategory.popular)
                    RealmHandler.addRealmObject(realmObject)
                }
                completionHandler(event,nil)
            }
        }
    }
    
    static func searchSeries(fileLocation: String, seriesCategory: String.seriesCategory, type: String.type, search: String, completionHandler: @escaping ([TV]?, Error?) -> Void) {
        if ConnectionStatus.shared.connected {
            Network.getExternalData(fileLocation: fileLocation) { (event: TVRequest?, error) in
                if let err = error {
                    completionHandler(nil,err)
                } else {
                    if let tvRequest = event {
                        let realmObject = RealmTVRequest(tvRequest: tvRequest, type: seriesCategory)
                        RealmHandler.addRealmObject(realmObject)
                    }
                    completionHandler(event?.series,nil)
                }
                
            }
        } else {
            RealmHandler.getRealmSeries(category: seriesCategory, search: search) { ( series: [TV])  in
                completionHandler(series,nil)
            }
        }
    }
    
    static func getVideos(endpoint: String, id: Int, completion: @escaping ([Video]) -> Void) {
        Network.getExternalData(fileLocation: endpoint) { (event: VideoRequest?, error) in
            if let results = event?.results {
                if results.count > 0 {
                    completion(results.filter({$0.site == "YouTube"}))
                }
            }
        }
        completion([])
    }
}
