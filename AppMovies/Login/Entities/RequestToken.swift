//
//  File.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 17/02/23.
//

import Foundation

struct RequestToken : Codable {
    var success: Bool?
    var expires_at: String?
    var request_token: String?
    
}
