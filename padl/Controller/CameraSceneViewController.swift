//
//  RegisterViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit

class CameraSceneViewController: UIViewController {
    
    let openCamera = "openCamera";
    
    override func viewDidLoad() {
        self.performSegue(withIdentifier: self.openCamera, sender: nil);
    }
    
}
