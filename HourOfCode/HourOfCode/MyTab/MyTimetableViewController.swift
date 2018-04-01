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
    
    @IBAction func testPressed(_ sender: UIButton) {
        
//        DataManager.subscribeToGroups(groupId: 1, subscribe: false) { (success, message) in
//            print(success)
//        }

        DataManager.getMyGroups { (success, myGroups, message) in
            print(myGroups ?? "NO GROUPS", myGroups!.count)
        }
    }

}
