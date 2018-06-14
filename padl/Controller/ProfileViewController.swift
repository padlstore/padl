//
//  RegisterViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: PadlBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        if let user = auth.currentUser {
            // User is authenticated
            
        } else {
            // User is in guest mode
            print("User is not authenticated.")
        }
    }
    
}
