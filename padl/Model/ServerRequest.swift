//
//  ServerRequest.swift
//  padl
//
//  Created by Matthew Feng on 6/14/18.
//  Copyright © 2018 Padl. All rights reserved.
//

import Foundation

class ServerRequest {
    
    static let serverURL: String = "https://testing.padl.store";
    static let registerTarget: String = "/newaccount";
    
    static func registerAccount(with email: String, and password: String, name: String,
                                school: String, location: String, completion: @escaping (_: DataResponse<Any>) -> ()) {
        
        let parameters: Parameters = [
            "email":        email,
            "password":     password,
            "displayName":  name,
            "location":     location,
        ];
        
        Alamofire.request(serverURL + registerTarget,
                          method: .post,
                          parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                completion(response);
            }
    }

}
