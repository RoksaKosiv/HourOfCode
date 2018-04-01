//
//  DistrictObject.swift
//  HourOfCode
//
//  Created by Roksolana Kosiv on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import Foundation

struct DistrictObject {
    let id: Int64
    let name: String?
    
    var schoolArray: [SchoolObject] = []
    
    init(data: JSONObject) {
        id = data["id"] as? Int64 ?? -1
        name = data["name"] as? String ?? ""
        schoolArray = self.parseSchoolArray(jsonObject: data)
    }
    
    func parseSchoolArray(jsonObject: JSONObject) -> [SchoolObject] {
        if let schoolArray = jsonObject["schools"] as? JSONArray {
            var arrayOfSchools: [SchoolObject] = []
            for schoolJson in schoolArray {
                let school = SchoolObject(data: schoolJson)
                arrayOfSchools.append(school)
            }
            return arrayOfSchools
        }
        return []
    }
}
