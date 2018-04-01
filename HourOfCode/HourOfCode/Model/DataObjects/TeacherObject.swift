//
//  TeacherObject.swift
//  HourOfCode
//
//  Created by Roksolana Kosiv on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import Foundation

struct TeacherObject {
    let id: Int64
    let username: String
    let telephone: String
    
    init(data: JSONObject) {
        id = data["id"] as? Int64 ?? -1
        username = data["username"] as? String ?? ""
        telephone = data["telephone"] as? String ?? ""
    }
}
