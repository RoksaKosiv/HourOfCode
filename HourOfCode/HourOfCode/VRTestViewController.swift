//
//  VRTestViewController.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 3/31/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit

class VRTestViewController: UIViewController {
    
    let loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func signUp(_ sender: UIButton ) {
        loginManager.signUp(username: "Viktor", email: "asas@asas.com", password: "123") { (success, message) in
            print(message)
        }
    }
    
    @IBAction func logIn(_ sender: UIButton ) {
        loginManager.logIn(email: "asas@asas.com", password: "123") { (success, message) in
            print(message)
        }
    }

    @IBAction func getUser(_ sender: UIButton ) {
        APIClient.sharedInstance.getUser(withID: "2") { (success, jsonObject, message) in
            print(message)
        }
    }
}
