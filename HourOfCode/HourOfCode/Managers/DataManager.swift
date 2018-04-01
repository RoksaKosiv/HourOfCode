//
//  DataManager.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import Foundation

class DataManager {
    static let apiClient = APIClient.sharedInstance
    
    static func getDiscticts(callback: @escaping (_ success: Bool ,_ districtsArray: [DistrictObject]?, _ message: String?) -> Void) {
        
        apiClient.getDistricts { (success, jsonObject, message) in
            if success,
                let jsonObject = jsonObject,
                let dictrictArray = jsonObject[APIClientKeys.data] as? JSONArray {
                var arrayOfDistricts: [DistrictObject] = []
                for districtJson in dictrictArray {
                    let school = DistrictObject(data: districtJson)
                    arrayOfDistricts.append(school)
                }
                callback(success, arrayOfDistricts, "Successfully Obtained Districts")
                
            } else {
                callback(success, [], nil)
            }
        }
        
    }
    
    static func getSchools(callback: @escaping (_ success: Bool ,_ schoolsArray: [SchoolObject]?, _ message: String?) -> Void) {
        
        apiClient.getSchools { (success, jsonObject, message) in
            if success,
                let jsonObject = jsonObject,
                let schoolArray = jsonObject[APIClientKeys.data] as? JSONArray {
                var arrayOfSchools: [SchoolObject] = []
                for schoolJson in schoolArray {
                    let school = SchoolObject(data: schoolJson)
                    arrayOfSchools.append(school)
                }
                callback(success, arrayOfSchools, "Successfully Obtained Schools")
                
            } else {
              callback(success, [], nil)
            }
        }
    
    }
    
    static func getSchoolGroups(id: Int64, callback: @escaping (_ success: Bool ,_ groupsArray: [GroupObject]?, _ message: String?) -> Void) {
        
        apiClient.getSchoolGroups(id: id) { (success, jsonObject, message) in
            if success,
                let jsonObject = jsonObject,
                let groupsArray = jsonObject[APIClientKeys.data] as? JSONArray {
                var arrayOfGroups: [GroupObject] = []
                for groupJson in groupsArray {
                    let group = GroupObject(data: groupJson)
                    arrayOfGroups.append(group)
                }
                callback(success, arrayOfGroups, "Successfully Obtained School")
                
            } else {
                callback(success, nil, nil)
            }
        }
        
    }
    
    
    static func getGroups(callback: @escaping (_ success: Bool ,_ groupsArray: [GroupObject]?, _ message: String?) -> Void) {
        
        apiClient.getGroups { (success, jsonObject, message) in
            if success,
                let jsonObject = jsonObject,
                let groupsArray = jsonObject[APIClientKeys.data] as? JSONArray {
                var arrayOfGroups: [GroupObject] = []
                for groupJson in groupsArray {
                    let group = GroupObject(data: groupJson)
                    arrayOfGroups.append(group)
                }
                callback(success, arrayOfGroups, "Successfully Obtained Groups")
                
            } else {
                callback(success, [], nil)
            }
        }
        
    }
    
    static func getGroup(id: Int64, callback: @escaping (_ success: Bool ,_ group: GroupObject?, _ message: String?) -> Void) {
        apiClient.getGroup(id: id) { (success, jsonObject, message) in
            if success,
                let jsonObject = jsonObject {
                let group = GroupObject(data: jsonObject)
                
                callback(success, group, "Successfully Obtained Group")
                
            } else {
                callback(success, nil, nil)
            }
        }
    }
    
    static func getMyGroups(callback: @escaping (_ success: Bool ,_ groupsArray: [GroupObject]?, _ message: String?) -> Void) {
        
        apiClient.getMyGroups { (success, jsonObject, message) in
            if success,
                let jsonObject = jsonObject,
                let groupsArray = jsonObject[APIClientKeys.mentoring] as? JSONArray {
                var arrayOfGroups: [GroupObject] = []
                for groupJson in groupsArray {
                    let group = GroupObject(data: groupJson)
                    arrayOfGroups.append(group)
                }
                callback(success, arrayOfGroups, "Successfully Obtained My Groups")
                
            } else {
                callback(success, [], nil)
            }
        }
        
    }
    
    static func subscribeToGroups(groupId: Int64, subscribe: Bool, callback: @escaping (_ success: Bool, _ message: String?) -> Void) {
        
        
        apiClient.subscribeToGroup(groupId: groupId, subscribe: subscribe) { (success, jsonObject, message) in
            callback(success, message)
        }
        
    }
    
    static func getTeacherForGroup(id: Int64, callback: @escaping (_ success: Bool ,_ teacher: TeacherObject?, _ message: String?) -> Void) {
        apiClient.getTeacherForGroup(id: id) { (success, jsonObject, message) in
            if success,
                let jsonObject = jsonObject {
                let teacher = TeacherObject(data: jsonObject)
                
                callback(success, teacher, "Successfully Obtained Teacher")
                
            } else {
                callback(success, nil, nil)
            }
        }
    }
    
}
