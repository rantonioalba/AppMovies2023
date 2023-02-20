//
//  Login.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 18/02/23.
//

import Foundation

struct Login : Codable {
    var username : String?
    var password : String?
    var request_token : String?
    
    init(username: String? = nil, password: String? = nil, request_token: String? = nil) {
        self.username = username
        self.password = password
        self.request_token = request_token
    }
}
