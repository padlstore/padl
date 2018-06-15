//
//  RegisterViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit

class RegisterViewController: PadlBaseViewController {
    
    @IBOutlet weak var registerButton: PadlRoundedButton!
    
    @IBOutlet weak var emailTextField: PadlRoundedTextField!
    @IBOutlet weak var passwordTextField: PadlRoundedTextField!
    @IBOutlet weak var nameTextField: PadlRoundedTextField!
    
    let school = "MIT";
    let location = "Simmons Hall";
    
    let signUpToHome = "SignUpToHome";

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);

        self.auth.addStateDidChangeListener() { auth, user in
            if user != nil {
                UIApplication.shared.keyWindow?.rootViewController?.performSegue(withIdentifier: self.signUpToHome, sender: nil);
            }
        }
    }
    
    @IBAction func onSignUpButtonTouchUpInside(_ sender: PadlRoundedButton) {
        let email = emailTextField.text ?? "";
        let password = passwordTextField.text ?? "";
        let name = nameTextField.text ?? "";
        
        guard
            email.count > 0,
            password.count > 0,
            name.count > 0
        else {
            return;
        }
        
        ServerRequest.registerAccount(with: email, and: password,
                                      name: name, school: self.school, location: self.location)
        { response in
            if let error = response.error {
                print(error);
                let alert = UIAlertController(title: "Registration Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert);
                alert.addAction(UIAlertAction(title: "OK", style: .default));
                
                self.present(alert, animated: true, completion: nil);
                return;
            }
            // Account creation was successful
            
            self.auth.signIn(withEmail: email, password: password)
            { user, error in
                // Account login failed, however
                if let _ = error, user == nil {
                    let alert = UIAlertController(title: "Login Failed",
                                                  message: "We couldn't log you in. Please try again!",
                                                  preferredStyle: .alert);
                    alert.addAction(UIAlertAction(title: "OK", style: .default));
                    self.present(alert, animated: true, completion: nil);
                    return;
                    // TODO: move the user to the initial login screen if this happens, which hopefully won't.
                }
                
            }
        }
        
    }
    
}
