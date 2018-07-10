//
//  CheckoutViewController.swift
//  padl
//
//  Created by Matthew Feng on 7/10/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import Foundation
import UIKit
import Stripe

class CheckoutViewController: PadlBaseViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var infoTableView: UITableView!
    
    @IBAction func cancelDidTouchUpInside(_ sender: PadlRoundedButton) {
        
    }
    
    @IBAction func confirmDidTouchUpInside(_ sender: PadlSubmitTransitionButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Checkout"
    }
    
}

extension CheckoutViewController: STPAddCardViewControllerDelegate {
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        // TODO: Call Padl Server to handle payment
    }
}

