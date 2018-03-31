//
//  LogInViewController.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 3/31/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit

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
        
        loginManager.logIn(email: email, password: password) { (success, message) in
            
            if success {
                self.presentOkAlertWithTitle(message, message: "", okActionHandler: { (_) in
                    
                })
            } else {
                self.presentOkAlertWithTitle(message, message: "", okActionHandler: { (_) in
                    
                })
            }
            print(message)
        }
    }

}
