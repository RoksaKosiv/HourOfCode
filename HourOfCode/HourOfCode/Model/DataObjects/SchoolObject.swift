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
    
    init(data: JSONObject) {
        id = data["id"] as? Int64 ?? -1
        name = data["name"] as? String ?? ""
        address = data["address"] as? String ?? ""
        latitude = data["latitude"] as? String ?? ""
        longitude = data["longitude"] as? String ?? ""
    }
}
