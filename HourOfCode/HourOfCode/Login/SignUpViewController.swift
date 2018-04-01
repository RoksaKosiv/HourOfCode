//
//  SignUpViewController.swift
//  HourOfCode
//
//  Created by Viktor Rudyk on 3/31/18.
//  Copyright © 2018 Roksolana Kosiv. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backToLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: UIButton ) {
        guard let username = usernameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text else {
                return
        }
        
        loginManager.signUp(username: username, email: email, password: password) { (success, message) in
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
