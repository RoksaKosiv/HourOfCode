//
//  SchoolObject.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import Foundation

struct SchoolObject {
    let address: String?
    let id: Int64
    let latitude: String?
    let longitude: String?
    let name: String?
    
    var groups: [GroupObject] = []
    
    init(data: JSONObject) {
        id = data["id"] as? Int64 ?? -1
        name = data["name"] as? String ?? ""
        address = data["address"] as? String ?? ""
        latitude = data["latitude"] as? String ?? ""
        longitude = data["longitude"] as? String ?? ""
        groups = parseSchoolArray(jsonObject: data)
    }
    
    func parseSchoolArray(jsonObject: JSONObject) -> [GroupObject] {
        if let groupsArray = jsonObject["groups"] as? JSONArray {
            var arrayOfGroups: [GroupObject] = []
            for schoolJson in groupsArray {
                let group = GroupObject(data: schoolJson)
                arrayOfGroups.append(group)
            }
            return arrayOfGroups
        }
        return []
    }
    
    mutating func sortGroupsByDate() -> [GroupObject] {
        return groups.sorted{
            guard let d1 = $0.dateStart, let d2 = $1.dateStart else { return false }
            return d1 < d2
        }
    }
}
