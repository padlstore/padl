//
//  RegisterViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit
import Foundation

class RegisterViewController: PadlBaseViewController {
    
    @IBOutlet weak var registerButton: PadlSubmitTransitionButton!
    
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
                self.registerButton.startFinishAnimation(1) {
                    let sb = UIStoryboard(name: "Main", bundle: nil);
                    let vc = sb.instantiateViewController(withIdentifier: "MainInterfaceTabBarController");
                    vc.transitioningDelegate = self;
                    self.present(vc, animated: true, completion: nil);
                }
//                self.performSegue(withIdentifier: self.signUpToHome, sender: nil);
            }
        }
    }
    
    @IBAction func onSignUpButtonTouchUpInside(_ sender: PadlSubmitTransitionButton) {
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
        
        self.registerButton.startLoadingAnimation();
        
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
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                    self.registerButton.setOriginalState();
                }
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
                    
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                        self.registerButton.setOriginalState();
                    }
                    
                    self.navigationController?.popToRootViewController(animated: true);
                    return;
                    // TODO: move the user to the initial login screen if this happens, which hopefully won't.
                }
            }
        }
        
    }
    
}
