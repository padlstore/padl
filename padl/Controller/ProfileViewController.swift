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
import Preheat
import Nuke

class ProfileViewController: PadlBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    @IBOutlet weak var boughtCollectionView: UICollectionView!
    @IBOutlet weak var soldCollectionView: UICollectionView!
    
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var propic: ProfilePictureImageView!
    
    var soldOfferURLs : [URL] = [];
    let serverURL: String = "https://testing.padl.store";
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if collectionView != self.boughtCollectionView {
            
            var urls = [URL]();
            
            for indexPath in indexPaths{
                let offerURL = self.soldOfferURLs[indexPath.row]
                urls.append(offerURL)
            }
            
            urls = indexPaths.flatMap {_ in urls}
            ImagePrefetcher(urls: urls).start()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]){
        print("Cancelling prefetching")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.boughtCollectionView {
            return 10
        }
        else{
            return min(10, soldOfferURLs.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.boughtCollectionView {
            let cell:ProfileBoughtCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "boughtCell", for: indexPath) as! ProfileBoughtCollectionViewCell
            
            cell.imageView.image = UIImage(named: "MIT.jpg")
            return cell
        }
        
        else{
            let cell:ProfileSoldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "soldCell", for: indexPath) as! ProfileSoldCollectionViewCell
            
            let cellURL = soldOfferURLs[indexPath.row]
            cell.imageView.kf.setImage(with: cellURL)
            return cell
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad();
        
        boughtCollectionView.delegate = self
        soldCollectionView.delegate = self
        
        boughtCollectionView.dataSource = self
        soldCollectionView.dataSource = self
        
        boughtCollectionView.prefetchDataSource = self as UICollectionViewDataSourcePrefetching
        
        soldCollectionView.prefetchDataSource = self as UICollectionViewDataSourcePrefetching
        soldCollectionView.isPrefetchingEnabled = true

        if Auth.auth().currentUser != nil {
            
            setProfileInfo() //If profile info was cached earlier, will be displayed immediately
            ProfileRequest.setupProfile(profileVC: self) //Then make another request to check if info has changed/if not cached earlier
            
        } else {
            // No user is signed in.
            
            
        }
    }
    
    func setProfileInfo() {
        
        if let displayText = UserDefaults.standard.object(forKey: "displayName") as? String {
            self.displayName.text = displayText
        }
        
        if let soldOffers = UserDefaults.standard.object(forKey: "offers"){
            for soldOffer in soldOffers as! [String] {
                self.soldOfferURLs.append(URL(string : soldOffer)!)
            }
        }
        
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


