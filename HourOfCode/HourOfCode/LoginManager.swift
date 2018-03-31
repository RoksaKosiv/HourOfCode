//
//  LoginManager.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 3/31/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class LoginManager {
    
    
    
    
    
    func signUp(username: String, email: String, password: String, completion: @escaping ((_ success: Bool, _ message: String) -> Void) ) {
        
        let parameters = [APIClientKeys.username: username,
                          APIClientKeys.email: email,
                          APIClientKeys.password: password,
        ]
        
        APIClient.sharedInstance.signUpRequest(parameters: parameters) { (success, dataJSON, message) in
            if success {
                let _message = message ?? "Sign Up Success"
                completion(true, _message)
            } else {
                let _message = message ?? "Sign Up Failed"
                completion(false, _message)
            }
        }
    }
    
    
    func logIn(email: String, password: String, completion: @escaping ((_ success: Bool, _ message: String) -> Void) ) {
        
        let parameters = [ APIClientKeys.email: email,
                          APIClientKeys.password: password
                          ]
        
        
        APIClient.sharedInstance.logInRequest(parameters: parameters) { (success, dataJSON, message) in
            if success {
                let _message = message ?? "Sign In Success"
                
                if let dataJSON = dataJSON,
                    let username = dataJSON[APIClientKeys.username] as? String,
                    let email = dataJSON[APIClientKeys.email] as? String {
                    
//                    NStorageManager.shared.logInUser(withUsername: username, email: email)
                    
                    completion(true, _message)
                } else {
                    completion(false, _message)
                }
            } else {
                let _message = message ?? "Sign In Failed"
                
                completion(false, _message)
            }
        }
    }
    
//    func signUp(parameters: JSONObject, completion: @escaping ((_ success: Bool, _ message: String) -> Void) ) {
//        APIClient.sharedInstance.signUpRequest(parameters: parameters) { (success, dataJSON, message) in
//            if success {
//                let _message = message ?? "Sign Up Success"
//                completion(true, _message)
//            } else {
//                let _message = message ?? "Sign Up Failed"
//                completion(false, _message)
//            }
//        }
//    }
//
//    func logOut() {
//        StorageManager.shared.logOutAllUsers()
//        NotificationCenter.default.post(name: .UserLoggedOut, object: nil, userInfo: nil)
//    }
//
//    func sendVerificationCode(parameters: JSONObject, completion: @escaping ((_ success: Bool, _ message: String) -> Void) ) {
//        APIClient.sharedInstance.verifySignUp(parameters: parameters) { (success, dataJSON, message) in
//            if success {
//                let _message = message ?? "Verification Success"
//                completion(true, _message)
//            } else {
//                let _message = message ?? "Verification Failed"
//                completion(false, _message)
//            }
//        }
//    }
//
//    func resendVerificationCode(parameters: JSONObject, completion: @escaping ((_ success: Bool, _ message: String) -> Void) ) {
//        APIClient.sharedInstance.resendVerificationCode(parameters: parameters) { (success, dataJSON, message) in
//            if success {
//                let _message = message ?? "Resend Code Success"
//                completion(true, _message)
//            } else {
//                let _message = message ?? "Resend Code Failed"
//                completion(false, _message)
//            }
//        }
//    }
}
