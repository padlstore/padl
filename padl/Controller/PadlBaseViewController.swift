//
//  PadlBaseViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit

class PadlBaseViewController: UIViewController {
    
    let notificationCenter = NotificationCenter.default;
    
    var keyboardAdjusted = false;
    var lastKeyboardOffset: CGFloat = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard));
        view.addGestureRecognizer(tap);
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !keyboardAdjusted {
            lastKeyboardOffset = getKeyboardHeight(notification: notification);
            view.frame.origin.y -= lastKeyboardOffset;
            keyboardAdjusted = true;
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted {
            view.frame.origin.y += lastKeyboardOffset;
            keyboardAdjusted = false;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        notificationCenter.addObserver(self, selector: #selector(PadlBaseViewController.keyboardWillShow(notification:)),
                                       name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        notificationCenter.addObserver(self, selector: #selector(PadlBaseViewController.keyboardWillHide(notification:)),
                                       name: NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    

    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo;
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue;
        return keyboardSize.cgRectValue.height;
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true);
    }
    
}
