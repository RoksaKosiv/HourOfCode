//
//  School+CoreDataClass.swift
//  
//
//  Created by Roksolana Kosiv on 3/31/18.
//
//

import Foundation
import CoreData

@objc(School)
public class School: NSManagedObject {
    
    func updateWithJSON(data: JSONObject) {
        id = data["id"] as? Int64 ?? -1
        name = data["name"] as? String ?? ""
        address = data["address"] as? String ?? ""
        latitude = data["latitude"] as? String ?? ""
        longitude = data["longitude"] as? String ?? ""
    }

}
