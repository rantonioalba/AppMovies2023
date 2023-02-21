//
//  Favorite+CoreDataProperties.swift
//  AppMovies
//
//  Created by Roberto Antonio Alba Hernández on 20/02/23.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var idShow: Int64
    @NSManaged public var name: String?
    @NSManaged public var firstAirDate: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?

}

extension Favorite : Identifiable {

}
