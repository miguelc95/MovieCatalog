//
//  myMoviesTests.swift
//  myMoviesTests
//
//  Created by Miguel Fernando Cuellar Gauna on 10/14/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import XCTest
@testable import myMovies

class myMoviesTests: XCTestCase {
    
    private let movieRequestExample =  Data("""
        {
        "page": 1,
        "total_results": 10000,
        "total_pages": 500,
        "results": [
        {
            "popularity": 548.811,
            "vote_count": 3043,
            "video": false,
            "poster_path": "/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
            "id": 475557,
            "adult": false,
            "backdrop_path": "/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg",
            "original_language": "en",
            "original_title": "Joker",
            "genre_ids": [
                80,
                18,
                53
            ],
            "title": "Joker",
            "vote_average": 8.7,
            "overview": "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.",
            "release_date": "2019-10-04"
        },
        {
            "popularity": 286.105,
            "vote_count": 2961,
            "video": false,
            "poster_path": "/2bXbqYdUdNVa8VIWXVfclP2ICtT.jpg",
            "id": 420818,
            "adult": false,
            "backdrop_path": "/nRXO2SnOA75OsWhNhXstHB8ZmI3.jpg",
            "original_language": "en",
            "original_title": "The Lion King",
            "genre_ids": [
                12,
                16,
                18,
                10751
            ],
            "title": "The Lion King",
            "vote_average": 7.1,
            "overview": "Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub's arrival. Scar, Mufasa's brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba's exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.",
            "release_date": "2019-07-19"
        },
        {
            "popularity": 237.403,
            "vote_count": 816,
            "video": false,
            "poster_path": "/ePXuKdXZuJx8hHMNr2yM4jY2L7Z.jpg",
            "id": 559969,
            "adult": false,
            "backdrop_path": "/uLXK1LQM28XovWHPao3ViTeggXA.jpg",
            "original_language": "en",
            "original_title": "El Camino: A Breaking Bad Movie",
            "genre_ids": [
                80,
                18,
                53
            ],
            "title": "El Camino: A Breaking Bad Movie",
            "vote_average": 7.3,
            "overview": "In the wake of his dramatic escape from captivity, Jesse Pinkman must come to terms with his past in order to forge some kind of future.",
            "release_date": "2019-10-11"
        },
        {
            "popularity": 166.123,
            "vote_count": 251,
            "video": false,
            "poster_path": "/uTALxjQU8e1lhmNjP9nnJ3t2pRU.jpg",
            "id": 453405,
            "adult": false,
            "backdrop_path": "/c3F4P2oauA7IQmy4hM0OmRt2W7d.jpg",
            "original_language": "en",
            "original_title": "Gemini Man",
            "genre_ids": [
                28,
                878,
                53
            ],
            "title": "Gemini Man",
            "vote_average": 5.9,
            "overview": "Henry Brogen, an aging assassin tries to get out of the business but finds himself in the ultimate battle: fighting his own clone who is 25 years younger than him and at the peak of his abilities.",
            "release_date": "2019-10-11"
        },
        {
            "popularity": 231.452,
            "vote_count": 4,
            "video": false,
            "poster_path": "/1XBMXs1BYj2QGg44qwX5jObJVGh.jpg",
            "id": 387837,
            "adult": false,
            "backdrop_path": null,
            "original_language": "ko",
            "original_title": "전망 좋은 집 2",
            "genre_ids": [
                18,
                10749
            ],
            "title": "House with a Nice View 2",
            "vote_average": 3.3,
            "overview": "The marriage of Yin Nan and Mei Ai (He Zhixing) has lasted for eight years. The passion and romance at the beginning have already been exhausted by the world. Yin Nan has nothing to do at home all day, waiting for the beauty to make money and come back to raise him. This makes Mei Ai feel very angry. The dual pressures of work and life have made Meiai start to look for excitement in other men. By going to bed with a strange man, Mei love seems to be able to vent a little dissatisfaction with the world. Over time, this has become her habit.  　　Next to Yin Nan’s family, a beautiful woman named Yi Yin (Jin Zhiyuan) was moved. Yi Yin discovered that her boyfriend, who had been with her for many years, actually stole himself and succumbed to his life. By chance, Yin Nan and Yi Yin met, and the two lonely hearts quickly approached. Mei Ai found that Yin Nan’s attitude towards himself was a lot colder, and he began to want to study the reasons behind it.",
            "release_date": "2015-05-27"
        }
        ]

        }
        """.utf8)
    
    func testMovieRequest() {
        let result : MoviesRequest?
        result = try? JSONDecoder().decode(MoviesRequest.self, from: movieRequestExample)
        XCTAssertNotNil(result)
        
    }
    
    func testDataFacadeCallOnlineAndOffline() {
        let endpoint = Endpoints.getMovieById.replacingOccurrences(of: "#id#", with: "1")
        DataFacade.getMovie(fileLocation: endpoint, id: 1) { (movie, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(movie)
        }
    }

    
}
