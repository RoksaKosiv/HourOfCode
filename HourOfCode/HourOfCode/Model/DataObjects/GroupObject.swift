//
//  GroupObject.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import Foundation

struct GroupObject {
    let dateEnd: String
    let dateStart: String
    let details: String
    let id: Int64
    let name: String
    let tacherId: Int64
    let schoolId: Int64
    let mentorId: Int64
    
    init(data: JSONObject) {
        id = data["id"] as? Int64 ?? -1
        name = data["name"] as? String ?? ""
        details = data["details"] as? String ?? ""
        tacherId = data["teacherId"] as? Int64 ?? -1
        schoolId = data["schoolId"] as? Int64 ?? -1
        mentorId = data["mentorId"] as? Int64 ?? -1
        dateEnd = data["dateEnd"] as? String ?? ""
        dateStart = data["dateStart"] as? String ?? ""
    }
}

