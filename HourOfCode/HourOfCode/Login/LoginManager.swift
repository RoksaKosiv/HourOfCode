//
//  LoginManager.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 3/31/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//


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
                completion(true, _message)
            } else {
                let _message = message ?? "Sign In Failed"
                completion(false, _message)
            }
        }
    }
    

}
