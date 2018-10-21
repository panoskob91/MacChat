//
//  LoginResponse.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 21/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class LoginResponse: NSObject
{
    let userEmail: String!
    let userToken: String!
    
    init(userEmail email: String, userToken token: String) {
        self.userEmail = email
        self.userToken = token
        super.init()
    }
}
