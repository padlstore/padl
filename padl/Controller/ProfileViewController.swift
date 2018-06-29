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
            let user = Auth.auth().currentUser
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                
                Alamofire.request("https://testing.padl.store/users/" + uid)
                    .responseJSON { response in
                        
                        print(response)
                        
                        if let json_result = response.result.value {
                            let json = JSON(json_result)
                            
                            self.displayName.text = json["displayName"].stringValue
                            
                            let url = URL(string: json["propic"].stringValue)
                            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                            self.propic.image = UIImage(data: data!)
                            
                            print("---")
                            
                            print(json["offers"])
                            print("---")
                            
                            var offerIdArray = [String]()
                            for (key,subJson):(String, JSON) in json["offers"] {
                                if key != "sentinel"{
                                    offerIdArray.append(key)
                                }
                            }
                            
                            print(offerIdArray)
                            
                        }
                        
                }
                
            }
        } else {
            // No user is signed in.
            // ...
        }
        
        /*
        if let user = auth.currentUser {
            // User is authenticated
            
        } else {
            // User is in guest mode
            print("User is not authenticated.")
        }
         */
    }
    
}
