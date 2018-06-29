//
//  LoginViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import NotificationBannerSwift

class LoginViewController: PadlBaseViewController {
    
    @IBOutlet weak var loginButton: PadlSubmitTransitionButton!
    
    @IBOutlet weak var emailTextField: PadlRoundedTextField!
    @IBOutlet weak var passwordTextField: PadlRoundedTextField!

    let loginToHome = "LoginToHome";
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.loginButton.startFinishAnimation(1) {
                    print("Logging in")
                    let sb = UIStoryboard(name: "Main", bundle: nil);
                    let vc = sb.instantiateViewController(withIdentifier: "MainInterfaceTabBarController");
                    vc.transitioningDelegate = self;
                    self.present(vc, animated: true, completion: nil);
                }
//                self.performSegue(withIdentifier: self.loginToHome, sender: nil);
            }
        }
    }
    
    @IBAction func loginDidTouchUpInside(_ sender: PadlSubmitTransitionButton) {
        let email = emailTextField.text ?? "";
        let password = passwordTextField.text ?? "";
        
        guard
            email.count > 0,
            password.count > 0
            else {
                return;
        }
        
        self.loginButton.startLoadingAnimation();
        
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error) in
            if let error = error, user == nil {
//                let alert = UIAlertController(title: "Sign In Failed",
//                                              message: error.localizedDescription,
//                                              preferredStyle: .alert);
//                alert.addAction(UIAlertAction(title: "OK", style: .default));
//
//                self.present(alert, animated: true, completion: nil);
                print(error.localizedDescription)
                let banner = NotificationBanner(title: "Sign In Failed",
                                                subtitle: "Looks like your email/password combination isn't correct",
                                                style: .danger);
                banner.show();
                Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { timer in
                    banner.dismiss();
                }
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    self.loginButton.setOriginalState();
                }
            }
        }
    }

}
