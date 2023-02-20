//
//  ProvidersTV.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 19/02/23.
//

import Foundation

import Foundation

// MARK: - WatchTVProviders
struct WatchTVProviders: Codable {
    let id: Int?
    let results: [String:Provider?]
}

struct Provider: Codable {
    let link: String?
    let flatrate: [Rate]?
    let free: [Rate]?
    let buy: [Rate]?
    let ads, rent: [Rate]?
}

// MARK: - Flatrate
struct Rate: Codable {
    let displayPriority: Int?
    let logoPath: String?
    let providerID: Int?
    let providerName: String?

    enum CodingKeys: String, CodingKey {
        case displayPriority = "display_priority"
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
    }
}

