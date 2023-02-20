//
//  ApiError.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 17/02/23.
//

import Foundation

struct ErrorApi: Codable {
    var success: Bool?
    var status_code: Int?
    var status_message: String?
}
