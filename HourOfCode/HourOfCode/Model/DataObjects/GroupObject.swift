//
//  GroupObject.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import Foundation

struct GroupObject {
    let dateEndString: String
    let dateStartString: String
    let details: String
    let id: Int64
    let name: String
    let tacherId: Int64
    let schoolId: Int64
    let mentorId: Int64
    
    let dateStart: Date?
    let dateEnd: Date?
    
    var school: SchoolObject? = nil
    
    init(data: JSONObject) {
        id = data["id"] as? Int64 ?? -1
        name = data["name"] as? String ?? ""
        details = data["details"] as? String ?? ""
        tacherId = data["teacherId"] as? Int64 ?? -1
        schoolId = data["schoolId"] as? Int64 ?? -1
        mentorId = data["mentorId"] as? Int64 ?? -1
        dateEndString = data["dateEnd"] as? String ?? ""
        dateStartString = data["dateStart"] as? String ?? ""
        
        dateStart = Date.stringToDate(dateString: dateStartString)
        dateEnd = Date.stringToDate(dateString: dateEndString)
        
        if let schoolData = data["schools"] as? JSONObject{
            school = SchoolObject(data: schoolData)
        }
    }
    
    var startTimeString: String {
        return dateStart?.toString(format: "HH:mm") ?? ""
    }
    
    var endTimeString: String {
        return dateEnd?.toString(format: "HH:mm") ?? ""
    }
    
    var startDateString: String {
        return dateStart?.toString(format: "EEEE, MMM d, yyyy") ?? ""
    }
}

