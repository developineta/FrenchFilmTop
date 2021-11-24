//
//  Film.swift
//  FrenchFilmTop
//
//  Created by ineta.magone on 22/11/2021.
//

import Foundation

struct FilmItem: Decodable {
    
    var title: String
    var poster_path: String
    var vote_average: Double
    var release_date: String
    var overview: String
    var backdrop_path: String
    
    
    enum CodingKeys: CodingKey{
        case title, overview
        case poster_path
        case vote_average
        case release_date
        case backdrop_path
    }
}

struct Films: Decodable {
    let results: [FilmItem]
}
