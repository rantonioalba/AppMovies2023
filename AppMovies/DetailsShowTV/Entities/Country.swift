//
//  Countries.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 20/02/23.
//

import Foundation

import Foundation


struct Country: Codable {
    let iso3166_1, englishName: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case englishName = "english_name"
    }
}
