//
//  ShowsTV.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 18/02/23.
//

import Foundation

// MARK: - ShowsTV
struct ShowsTV: Codable {
    let page: Int?
    let results: [Result]?
    let totalResults, totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct Result: Codable {
    var posterPath: String?
    var popularity: Double?
    var id: Int?
    var backdropPath: String?
    var voteAverage: Double?
    var overview, firstAirDate: String?
    var originCountry: [String]?
    var genreIDS: [Int]?
    var originalLanguage: String?
    var voteCount: Int?
    var name, originalName: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity, id
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
    }
}

enum OriginCountry: String, Codable {
    case gb = "GB"
    case jp = "JP"
    case us = "US"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
}
