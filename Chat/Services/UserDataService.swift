//
//  UserDataService.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 21/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class UserDataService: NSObject
{
    static let sharedInstance = UserDataService()
    
    fileprivate var _id = ""
    fileprivate var _avatarColor = ""
    fileprivate var _avatarName = ""
    fileprivate var _email = ""
    fileprivate var _name = ""
    
    var id: String
    {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var avatarColor: String
    {
        get {
            return _avatarColor
        }
        set {
            _avatarColor = newValue
        }
    }
    
    var avatarName: String
    {
        get {
            return _avatarName
        }
        set {
            _avatarName = newValue
        }
    }
    
    var email: String
    {
        get {
            return _email
        }
        set {
            _email = newValue
        }
    }
    
    var name: String
    {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    override var description: String {
        get {
            let returnedString = "id : \(self.id) \n"
                + "name: \(self.name) \n"
                + "email: \(self.email) \n"
                + "avatarName: \(self.avatarName) \n"
                + "avatarColor: \(self.avatarColor)"
            return returnedString
        }
    }
    
    class func initializeUserDataServiceSingletonWith(object userObject: User)
    {
        UserDataService.sharedInstance.id = userObject.userID
        UserDataService.sharedInstance.name = userObject.userName
        UserDataService.sharedInstance.email = userObject.userEmail
        UserDataService.sharedInstance.avatarName = userObject.avatarName
        UserDataService.sharedInstance.avatarColor = userObject.avatarColor
    }
    
    func jsonify() -> [String: String] {
        var json: [String: String] = [:]
        json["_id"] = self.id
        json["name"] = self.name
        json["email"] = self.email
        json["avatarName"] = self.avatarName
        json["avatarColor"] = self.avatarColor
        
        return json
    }
    
    private func resetUserData()
    {
        self.id = ""
        self.name = ""
        self.email = ""
        self.avatarName = ""
        self.avatarColor = ""
    }
    
    func logoutUser()
    {
        resetUserData()
        AuthService.sharedInstance.resetData()
        MessageService.sharedInstance.emptyChannels()
//        let mainStoryBoard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
//        let channelVC = mainStoryBoard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "ChannelVC"))
        print("TEST")
        
    }
}
