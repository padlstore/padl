//
//  RegisterViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit
import FirebaseAuth
import Alamofire
import SwiftyJSON
import Kingfisher

class ProfileViewController: PadlBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var boughtCollectionView: UICollectionView!
    
    @IBOutlet weak var soldCollectionView: UICollectionView!
    
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var propic: ProfilePictureImageView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.boughtCollectionView {
            let cell:ProfileBoughtCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "boughtCell", for: indexPath) as! ProfileBoughtCollectionViewCell
            
            cell.imageView.image = UIImage(named: "MIT.jpg")
            
            return cell
        }
        
        else{
            let cell:ProfileSoldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "soldCell", for: indexPath) as! ProfileSoldCollectionViewCell
            
            
            
            cell.imageView.image = UIImage(named : "MIT.jpg")
            
            return cell
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad();
        
        boughtCollectionView.delegate = self
        soldCollectionView.delegate = self
        boughtCollectionView.dataSource = self
        soldCollectionView.dataSource = self
        
        if Auth.auth().currentUser != nil {
            
            self.setProfileInfo()
            
            ProfileRequest.setupProfile()
            
            self.setProfileInfo()
            
        } else {
            // No user is signed in.
            // ...
        }
    }
    
    func setProfileInfo() {
        
        //UserDefaults.standard.set(self.offers, forKey: "offers")
        
        self.displayName.text = UserDefaults.standard.object(forKey: "displayName") as? String
        
        //Get profile picture from cache
        ImageCache.default.retrieveImage(forKey: "profilePic", options: nil) {
            image, cacheType in
            if let image = image {
                self.propic.image = image
            } else {
                print("Not exist in cache.")
            }
        }
        
    }
    
}
