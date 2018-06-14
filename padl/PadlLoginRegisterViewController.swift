//
//  PadlLoginRegisterViewController.swift
//  
//
//  Created by Matthew Feng on 6/13/18.
//

import UIKit
import FirebaseAuth

class PadlLoginRegisterViewController: PadlBaseViewController {
    
    @IBOutlet weak var loginButton: PadlRoundedButton!
    @IBOutlet weak var registerButton: PadlRoundedButton!
    
    let loginAutomatically = "LoginAutomatically";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: self.loginAutomatically, sender: nil);
            }
        }
    }
}
