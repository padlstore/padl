//
//  PadlRoundedButton.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit

class PadlRoundedButton: UIButton {
    
    let defaultButtonWidth: CGFloat = 200.0;
    let defaultButtonHeight: CGFloat = 50.0;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        let center: CGPoint = self.center;
        
        let originX = center.x - defaultButtonWidth / 2;
        let originY = center.y - defaultButtonHeight / 2;
        
        self.frame = CGRect(x: originX, y: originY,
                            width: defaultButtonWidth, height: defaultButtonHeight);
        
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.clipsToBounds = true;
        self.backgroundColor = .clear;
        self.layer.borderColor = UIColor.white.cgColor;
        self.layer.borderWidth = 1.0;
    }
}
