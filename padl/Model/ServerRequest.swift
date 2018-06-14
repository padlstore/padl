//
//  ServerRequest.swift
//  padl
//
//  Created by Matthew Feng on 6/14/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import Foundation
import Alamofire

class ServerRequest {
    
    let serverURL: NSURL = NSURL(string: "testing.padl.store")!
    
    static func registerAccount(with email: String, and password: String, name: String, location) -> (success: Bool, message: String) {
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url);
        
        var bodyData = "";
        
        request.httpMethod = "POST";

    }
    
    
    
}
