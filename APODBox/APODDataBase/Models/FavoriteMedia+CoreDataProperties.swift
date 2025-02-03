//
//  FavoriteMedia+CoreDataProperties.swift
//  APODBox
//
//  Created by Denis Couras on 02/02/25.
//
//

import Foundation
import CoreData


extension FavoriteMedia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMedia> {
        return NSFetchRequest<FavoriteMedia>(entityName: "FavoriteMedia")
    }

    @NSManaged public var copyright: String?
    @NSManaged public var date: String?
    @NSManaged public var explanation: String?
    @NSManaged public var hdurl: String?
    @NSManaged public var media_type: String?
    @NSManaged public var service_version: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}

extension FavoriteMedia : Identifiable {

}
