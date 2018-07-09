//
//  Offer.swift
//  padl
//
//  Created by Matthew Feng on 7/9/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import Foundation

class Offer {
    
    var offerId: String
    var offerName: String
    var offerLocation: String
    var offerDesc: String
    var offerPrice: Int
    var sellerId: String
    var offerImages: [String : String]
    var hitDict: [String : Any]?
    
    init(offerId: String, name: String, location: String, desc: String, price: Int,
         sellerId: String, images: [String : String], dict: [String : Any]?) {
        self.offerId = offerId
        self.offerName = name
        self.offerLocation = location
        self.offerDesc = desc
        self.offerPrice = price
        self.sellerId = sellerId
        self.offerImages = images
        self.hitDict = dict
    }
    
}
