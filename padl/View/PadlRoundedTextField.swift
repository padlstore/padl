//
//  PadlRoundedTextField.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit

class PadlRoundedTextField: UITextField {
    
    let defaultHeight = CGFloat(50.0);

    override func awakeFromNib() {
        super.awakeFromNib();
        
        let width = self.frame.width;

        let originX = self.center.x - width / 2;
        let originY = self.center.y - defaultHeight / 2;
        
        self.frame = CGRect(x: originX, y: originY,
                            width: width, height: defaultHeight);
        
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.clipsToBounds = true;
        self.backgroundColor = .clear;
        self.layer.borderColor = UIColor.white.cgColor;
        self.layer.borderWidth = 1.0;
        
        // Set text color
        self.textColor = UIColor.white;
        self.font = UIFont.init(name: "Futura PT Book", size: 12);
        
        // Set left padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(15.0), height: defaultHeight));
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewMode.always;
    }
}
