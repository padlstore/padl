//
//  RegisterViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/13/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: PadlBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var boughtCollectionView: UICollectionView!
    
    @IBOutlet weak var soldCollectionView: UICollectionView!
    
    
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
        
        if let user = auth.currentUser {
            // User is authenticated
            
        } else {
            // User is in guest mode
            print("User is not authenticated.")
        }
    }
    
}
