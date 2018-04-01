//
//  URLBuilder.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 3/31/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import Foundation

class URLBuilder {
    
    //****** DEBUG ******
    static let baseURL = "https://hourofcode-xgxtsuothj.now.sh/api" //"https://hourofcode-yulujwpfvg.now.sh/api" // "https://hourofcode-dlcsjamsms.now.sh/api"
    
    //****** PRODUCTION ******
    //static let baseURL = ""
    
    static var createUserPath: String {
        get {
            return baseURL + "/Users"
        }
    }
    
    static var logInPath: String {
        get {
            return baseURL + "/Users/login"
        }
    }
    
    static var getUserPath: String {
        get {
            return baseURL + "/Users/"
        }
    }
    
    static var districtsPath: String {
        get {
            return baseURL + "/Districts"
        }
    }
    
    static var schoolsPath: String {
        get {
            return baseURL + "/Schools"
        }
    }
    
    static var groupsPath: String {
        get {
            return baseURL + "/Groups"
        }
    }
}
