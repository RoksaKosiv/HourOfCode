//
//  SettingsViewController.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 4/1/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit

class MyTimetableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        APIClient.sharedInstance.logout()
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
            UIApplication.shared.delegate?.window??.rootViewController?.dismiss(animated: false, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = loginViewController
        }
    }
    

}