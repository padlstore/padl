//
//  HomeViewController.swift
//  
//
//  Created by Nikhil Murthy on 6/14/18.
//

import UIKit
import InstantSearch
import Alamofire
import Kingfisher

fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0);

class HomeViewController: PadlBaseViewController, HitsCollectionViewDataSource, HitsCollectionViewDelegate {
    
    // Specify the Home -> Offer segue.
    let homeToOffer: String = "HomeToOffer"
    
    var instantSearch: InstantSearch!
    @IBOutlet weak var hitsCollection: HitsCollectionWidget!
    @IBOutlet weak var searchBar: SearchBarWidget!
    var hitsController: HitsController!

    fileprivate let reuseIdentifier = "offerCell";

    // Prepare for segue into viewing an offer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem();
        backItem.tintColor = UIColor.black;
        navigationItem.backBarButtonItem = backItem;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hitsController = HitsController(collection: hitsCollection)
        hitsCollection.dataSource = hitsController
        hitsCollection.delegate = hitsController
        hitsController.collectionDataSource = self
        hitsController.collectionDelegate = self

        InstantSearch.shared.registerAllWidgets(in: self.view);

        // Set up search
        searchBar.placeholder = "Search for items"

        //Set up profile
        ProfileRequest.setupProfile()

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath,
                                 containing hit: [String : Any]) -> UICollectionViewCell {
        let cell = hitsCollection.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.blue
//        print(hit)
        let urlStr = (hit["pictures"] as? [String: Any])?["0"] as? String
        let url = URL(string: urlStr!)
        (cell as! HomeOfferCollectionViewCell).imageView.kf.setImage(with: url)
        (cell as! HomeOfferCollectionViewCell).priceLabel.text = hit["price"] as? String

        print("test")

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath,
                                 containing hit: [String : Any]) {
        print("hit \(String(describing: hit["name"]!)) has been clicked!")
    }
}

extension HitsController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.size.width / 3.0
        let height = width

        print("width \(width)")

        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) ->  CGFloat {
        return CGFloat(0.0)
    }
}
