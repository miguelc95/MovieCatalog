//
//  Endpoints.swift
//  myMovies
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class Endpoints {
    static var baseURL = "https://api.themoviedb.org/3"
    static var getEvents = "https://api.themoviedb.org/3/%type%/%event%"
    static var imageURL = "https://image.tmdb.org/t/p/w500/"
    static var search = "https://api.themoviedb.org/3/search/movie?api_key=\(ApiConstants.api_key)&query=#query#&page=1"
    static var getMovieById = "https://api.themoviedb.org/3/movie/#id#"
    static var getSerieById = "https://api.themoviedb.org/3/tv/#id#"
    static var rateMovie = "https://api.themoviedb.org/3/#type#/#Id#?api_key=\(ApiConstants.api_key)"
    static var getMovieVideos = "https://api.themoviedb.org/3/#type#/#movie_id#/videos?api_key=\(ApiConstants.api_key)"
    static var youtube = "https://www.youtube.com/embed/#key#"
}

class ApiConstants {
    static var accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODU4MjE1NWIyNzNlY2ZjYjYwNWJlYjg2MjYwNDIwNyIsInN1YiI6IjVkYTEwYTVlZTg2MDE3MDAxMmFiMzhjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.iadjWWwYEepEJdLZLUQppWWeSqST2krKce4ozHZk9Xw"
    static var api_key = "d8582155b273ecfcb605beb862604207"
}
