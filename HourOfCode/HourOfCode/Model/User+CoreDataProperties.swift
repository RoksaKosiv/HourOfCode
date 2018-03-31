//
//  User+CoreDataProperties.swift
//  
//
//  Created by Roksolana Kosiv on 3/31/18.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var userID: Int64
    @NSManaged public var myGroups: NSSet?

}

// MARK: Generated accessors for myGroups
extension User {

    @objc(addMyGroupsObject:)
    @NSManaged public func addToMyGroups(_ value: Group)

    @objc(removeMyGroupsObject:)
    @NSManaged public func removeFromMyGroups(_ value: Group)

    @objc(addMyGroups:)
    @NSManaged public func addToMyGroups(_ values: NSSet)

    @objc(removeMyGroups:)
    @NSManaged public func removeFromMyGroups(_ values: NSSet)

}
