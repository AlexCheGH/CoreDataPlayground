//
//  Profile+CoreDataProperties.swift
//  CoreDataTestApp
//
//  Created by AP Aliaksandr Chekushkin on 6/20/21.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: NSObject?

}

extension Profile : Identifiable {

}
