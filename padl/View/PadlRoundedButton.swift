//
//  PadlRoundedButton.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit

class PadlRoundedButton: UIButton {
    
    let defaultButtonHeight: CGFloat = 50.0;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        let center: CGPoint = self.center;
        let height: CGFloat = self.frame.height;
        let width: CGFloat = self.frame.width;
        
        let originX = center.x - width / 2;
        let originY = center.y - height / 2;
        
        self.frame = CGRect(x: originX, y: originY,
                            width: width, height: height);
        
        self.layer.cornerRadius = height / 2;
        self.clipsToBounds = true;
        self.layer.borderWidth = 1.0;
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable override var backgroundColor: UIColor? {
        didSet {
            self.layer.backgroundColor = backgroundColor?.cgColor
        }
    }
}
