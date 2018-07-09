//
//  OfferViewController.swift
//  padl
//
//  Created by Matthew Feng on 6/29/18.
//  Copyright © 2018 Padl. All rights reserved.


import Foundation
import FSPagerView
import Nuke

class OfferViewController: PadlBaseViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    
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
    
    @IBOutlet weak var offerNameLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    @IBOutlet weak var offerLocationLabel: UILabel!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var sellerProfilePic: UIImageView!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var messageBuyView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad();
        
        messageBuyView.backgroundColor = .white;
        let blurEffect = UIBlurEffect(style: .prominent);
        let blurEffectView = UIVisualEffectView(effect: blurEffect);
        blurEffectView.frame = messageBuyView.frame;
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        blurEffectView.alpha = 1.0;
        mainView.insertSubview(blurEffectView, at: 1);

        messageBuyView.layer.shadowRadius = 2.5;
        messageBuyView.layer.shadowOpacity = 0.6;
        messageBuyView.layer.shadowOffset = CGSize(width: 0, height: -0.4);
        messageBuyView.layer.shadowColor = UIColor.gray.cgColor
        
        blurEffectView.layer.masksToBounds = false;

        self.imagePageView.dataSource = self
        self.imagePageView.delegate = self
        
        self.imagePageControl.numberOfPages = self.numberOfItems(in: self.imagePageView);
        self.imagePageControl.setStrokeColor(.white, for: .normal);
        self.imagePageControl.setStrokeColor(.white, for: .selected);
        self.imagePageControl.setFillColor(.clear, for: .normal);
        self.imagePageControl.setFillColor(.white, for: .selected);

//        self.navigationController?.navigationBar.barTintColor;
//        self.navigationController?.navigationBar.titleTextAttributes
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
    
    /* Called when the "Message Seller" button is pressed */
    @IBAction func messageSellerButton(_ sender: PadlRoundedButton) {
        print("Message Seller button pressed!")
    }
    
    /* Called when the "Purchase Offer" button is pressed */
    @IBAction func purchaseOffer(_ sender: PadlSubmitTransitionButton) {
        print("Purchase Offer button pressed!")
        
    }
}
