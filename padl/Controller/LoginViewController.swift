//
//  LoginViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: PadlBaseViewController {
    
    @IBOutlet weak var loginButton: PadlRoundedButton!
    
    @IBOutlet weak var emailTextField: PadlRoundedTextField!
    @IBOutlet weak var passwordTextField: PadlRoundedTextField!

    let loginToHome = "LoginToHome";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: self.loginToHome, sender: nil);
            }
        }
    }
    
    @IBAction func loginDidTouchUpInside(_ sender: PadlRoundedButton) {
        let email = emailTextField.text ?? "";
        let password = passwordTextField.text ?? "";
        
        guard
            email.count > 0,
            password.count > 0
            else {
                return;
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error) in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert);
                alert.addAction(UIAlertAction(title: "OK", style: .default));
                
                self.present(alert, animated: true, completion: nil);
            }
        }
    }

}
