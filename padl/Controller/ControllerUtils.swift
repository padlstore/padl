//
//  ControllerUtils.swift
//  padl
//
//  Created by Matthew Feng on 6/14/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import UIKit

class ControllerUtils {
    static func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
}
