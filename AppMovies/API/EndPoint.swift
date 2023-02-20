//
//  EndPoint.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 17/02/23.
//


import Foundation

protocol EndPoint {
    var base : String {get}
    var path: String {get}
}

extension EndPoint {
    var urlComponents:URLComponents {
        print(base)
        
        var components = URLComponents(string: base)!
        print(path)
        components.path = path
        return components
    }
    
    var url : String {
//        print(urlComponents.url!)
//        print((urlComponents.url?.absoluteString)!)
        
        let urlString = (urlComponents.url?.absoluteString)!
        
//        print(urlString)
        
        return urlString
    }
}
