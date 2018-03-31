//
//  Group+CoreDataProperties.swift
//  
//
//  Created by Roksolana Kosiv on 3/31/18.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var dateEnd: String?
    @NSManaged public var dateStart: String?
    @NSManaged public var details: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var tacherId: Int64
    @NSManaged public var teacherName: String?
    @NSManaged public var teacherPhone: String?
    @NSManaged public var school: School?
    @NSManaged public var user: User?

}
