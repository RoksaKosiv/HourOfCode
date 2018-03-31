//
//  Group+CoreDataClass.swift
//  
//
//  Created by Roksolana Kosiv on 3/31/18.
//
//

import Foundation
import CoreData

@objc(Group)
public class Group: NSManagedObject {
    
    func updateWithJSON(data: JSONObject) {
        id = data["id"] as? Int64 ?? -1
        name = data["name"] as? String ?? ""
        details = data["details"] as? String ?? ""
        tacherId = data["teacherId"] as? Int64 ?? -1
        dateEnd = data["dateEnd"] as? String ?? ""
        dateStart = data["dateStart"] as? String ?? ""
    }
    
    func updateTeacherWithJSON(teacherData: JSONObject) {
        tacherId = teacherData["id"] as? Int64 ?? -1
        teacherName = teacherData["name"] as? String ?? ""
        teacherPhone = teacherData["phone"] as? String ?? ""
    }

}
