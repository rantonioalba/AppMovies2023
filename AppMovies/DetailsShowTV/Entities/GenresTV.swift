//
//  Genres.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 19/02/23.
//

import Foundation

struct GenresTV: Codable {
    let genres : [GenreTV]?
}

struct GenreTV: Codable {
    let id : Int?
    let name: String?
}
