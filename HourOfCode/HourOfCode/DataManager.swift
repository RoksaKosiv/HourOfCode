//
//  DataManager.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import Foundation

class DataManager {
    let apiClient = APIClient.sharedInstance
    
    func getSchools(callback: @escaping (_ success: Bool ,_ schoolsArray: [SchoolObject]?, _ message: String?) -> Void) {
        
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
    
    func getSchool(id: Int64, callback: @escaping (_ success: Bool ,_ group: SchoolObject?, _ message: String?) -> Void) {
        
        apiClient.getSchool(id: id) { (success, jsonObject, message) in
            if success,
                let jsonObject = jsonObject {
                let school = SchoolObject(data: jsonObject)
                
                callback(success, school, "Successfully Obtained School")
                
            } else {
                callback(success, nil, nil)
            }
        }
        
    }
    
    
    func getGroups(callback: @escaping (_ success: Bool ,_ groupsArray: [GroupObject]?, _ message: String?) -> Void) {
        
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
    
    func getGroup(id: Int64, callback: @escaping (_ success: Bool ,_ group: GroupObject?, _ message: String?) -> Void) {
        
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
    
}
