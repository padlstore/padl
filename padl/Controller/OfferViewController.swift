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
    
    @IBOutlet weak var imagePageView: FSPagerView! {
        didSet {
            self.imagePageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    var imgURLs: [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.imagePageView.dataSource = self
        self.imagePageView.delegate = self

//        self.navigationController?.navigationBar.barTintColor;
//        self.navigationController?.navigationBar.titleTextAttributes
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imgURLs.count;
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index);
        
        Nuke.loadImage(with: URL.init(string: self.imgURLs[index])!,
                       into: cell.imageView!);
        
        cell.textLabel?.text = "";
        return cell;
    }
}
