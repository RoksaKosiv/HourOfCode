//
//  LogInViewController.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 3/31/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit
import MBProgressHUD

class LogInViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var usernameContainerView: UIView!
    
    @IBOutlet weak var emailContainerView: UIView!
    
    @IBOutlet weak var passwordContainerView: UIView!
    
    @IBOutlet weak var confirmPasswordContainerView: UIView!
    
    @IBOutlet weak var verificationCodeContainerView: UIView!
    
    @IBOutlet weak var forgotPasswordView: UIView!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signInSignUpSwitchLabel: UILabel!
    @IBOutlet weak var signInSignUpSwitchButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    
    @IBOutlet weak var usernameSeparationView: UIView!
    @IBOutlet weak var emailSeparationView: UIView!
    @IBOutlet weak var passwordSeparationView: UIView!
    @IBOutlet weak var confirmPasswordSeparationView: UIView!
    @IBOutlet weak var verificationCodeSeparationView: UIView!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    
    let loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func logInPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
            return
        }
        
        MBProgressHUD.showAnimated(onView: self.view)
        loginManager.logIn(email: email, password: password) { (success, message) in
            MBProgressHUD.hideAnimated(forView: self.view)
            if success {
                self.performLoginTransition()
            } else {
                self.presentOkAlertWithTitle(message, message: "", okActionHandler: { (_) in
                    
                })
            }
            print(message)
        }
    }
    
    fileprivate func performLoginTransition() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let baseTabBarController = storyboard.instantiateViewController(withIdentifier: "BaseTabBarController")
            UIApplication.shared.delegate?.window??.rootViewController?.dismiss(animated: false, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = baseTabBarController
        }
    }
    
    @IBAction func testPressed(_ sender: UIButton) {

//        dataManager.getSchools { (success, schools, message) in
//            print(schools)
//        }
//        dataManager.getGroup(id: 1) { (success, group, message) in
//            if let group = group {
//                print(group)
//            }
//        }
        
//        DataManager.getSchoolGroups(id: 1) { (success, school, message) in
//            if let school = school {
//                print(school)
//            }
//        }
       
    }

}
