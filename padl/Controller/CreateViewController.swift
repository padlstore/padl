//
//  OfferViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/29/18.
//  Copyright © 2018 Padl. All rights reserved.


import Foundation
import FSPagerView
import Nuke

class CreateViewController: PadlBaseViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    
    public var offer: Offer? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBOutlet weak var imagePageView: FSPagerView! {
        didSet {
            self.imagePageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var imagePageControl: FSPageControl!
    
    @IBOutlet weak var offerNameTextField: UITextField!
    @IBOutlet weak var offerPriceTextField: UITextField!
    
    
    //@IBOutlet weak var offerNameLabel: UILabel!
    //@IBOutlet weak var offerPriceLabel: UILabel!
    //@IBOutlet weak var offerLocationLabel: UILabel!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var sellerProfilePic: UIImageView!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var messageBuyView: UIView!
    
    @IBOutlet weak var buyButton: PadlSubmitTransitionButton!
    
    private func priceToString(price: Int) -> String {
        let dollars: Int = price / 100
        let cents: String = String(price % 100).padding(toLength: 2, withPad: "0", startingAt: 0)
        return "$\(dollars).\(cents)"
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        
        /*
        //offerNameLabel.text = self.offer?.offerName
        
        //let priceString = self.priceToString(price: (self.offer?.offerPrice)!)
        //offerPriceLabel.text = priceString
        //offerLocationLabel.text = self.offer?.offerLocation
        offerDescriptionLabel.text = self.offer?.offerDesc
        
        offerDescriptionLabel.sizeToFit()
        
        //buyButton.setTitle("Purchase (\(priceString))", for: UIControlState.normal)
//        sellerNameLabel.text = self.offer?.sellerId

        messageBuyView.backgroundColor = .white;
        messageBuyView.layer.shadowRadius = 2.5;
        messageBuyView.layer.shadowOpacity = 0.6;
        messageBuyView.layer.shadowOffset = CGSize(width: 0, height: -0.4);
        messageBuyView.layer.shadowColor = UIColor.gray.cgColor

        self.imagePageView.dataSource = self
        self.imagePageView.delegate = self
        
        self.imagePageControl.numberOfPages = self.numberOfItems(in: self.imagePageView);
        self.imagePageControl.setStrokeColor(.white, for: .normal);
        self.imagePageControl.setStrokeColor(.white, for: .selected);
        self.imagePageControl.setFillColor(.clear, for: .normal);
        self.imagePageControl.setFillColor(.white, for: .selected);

//        self.navigationController?.navigationBar.barTintColor;
//        self.navigationController?.navigationBar.titleTextAttributes
 
        */
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.offer!.offerImages.count - 1; // -1 because of sentinel value
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index);
        
        Nuke.loadImage(with: URL.init(string: self.offer!.offerImages[String(index)]!)!,
                       into: cell.imageView!);
        cell.imageView!.contentMode = UIViewContentMode.scaleAspectFill;
        cell.imageView!.clipsToBounds = true;
        
        return cell;
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.imagePageControl.currentPage = targetIndex;
    }
    
    
    
    
    /* DONE */
    
    /* Called when the "Cancel" button is pressed */
    
    @IBAction func cancelButton(_ sender: PadlRoundedButton) {
        print("Cancel button pressed!")
    }
    
    
    /* Called when the "Sell Offer!" button is pressed */
    
    @IBAction func sellOffer(_ sender: PadlSubmitTransitionButton) {
        print("Sell Offer button pressed!")
    }
}
