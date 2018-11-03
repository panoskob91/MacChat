//
//  User.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 03/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class User: NSObject
{
    let userID: String!
    let userName: String!
    let userEmail: String!
    let avatarName: String!
    let avatarColor: String!
    
    init(_ userDictionary: [String: String]) {
        self.userID = userDictionary["_id"]
        self.userName = userDictionary["name"]
        self.userEmail = userDictionary["email"]
        self.avatarName = userDictionary["avatarName"]
        self.avatarColor = userDictionary["avatarColor"]
        super.init()
    }
    
    class func createUserInputDictionary(_ input: [String: Any]) -> [String: String]?
    {
        var jsonUserInputDictionary: [String: String]?
        guard let id = input["_id"] as? String,
            let name = input["name"] as? String,
            let email = input["email"] as? String,
            let avatarName = input["avatarName"] as? String,
            let avatarColor = input["avatarColor"] as? String else {
                return nil
        }
        jsonUserInputDictionary = [:]
        jsonUserInputDictionary!["_id"] = id
        jsonUserInputDictionary!["name"] = name
        jsonUserInputDictionary!["email"] = email
        jsonUserInputDictionary!["avatarName"] = avatarName
        jsonUserInputDictionary!["avatarColor"] = avatarColor
        
        return jsonUserInputDictionary
    }
}
