//
//  ProfilePictureImageView.swift
//  padl
//
//  Created by Matthew Feng on 6/14/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit

class ProfilePictureImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib();
        
        let height = self.frame.height;
        
        self.layer.cornerRadius = height / 2;
        self.clipsToBounds = true;
        self.backgroundColor = .clear;
        self.layer.borderColor = UIColor.white.cgColor;
        self.layer.borderWidth = 0.0;
    }
}
