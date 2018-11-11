//
//  AuthService.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 20/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class AuthService
{
    static let sharedInstance: AuthService = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool
    {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String
    {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String
    {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String,
                      password: String,
                      successBlock: (() -> Void)?,
                      failBlock: (@escaping(RSBaseResponse) -> Void))
    {
        Networking.sharedInstance.registerUser(email: email, password: password, success: { (successResponse) in
            successBlock?()
        }) { (failureResponse) in
            guard let messageDictionary = failureResponse.responseObject as? [String : String] else {
                DispatchQueue.main.async {
                    failBlock(failureResponse)
                }
                return
            }
            guard let alertMessage = messageDictionary["message"] else {
                DispatchQueue.main.async {
                    failBlock(failureResponse)
                }
                return
            }
            
            DispatchQueue.main.async {
                let button: NSButton = NSButton(title: "OK", target: self, action: nil)
                let alert: Alert = Alert(messageText: alertMessage, buttons: [button], icon: nil)
                alert.showAlert()
                failBlock(failureResponse)
            }
        }
    }
    
    func loginUser(email: String,
                   password: String,
                   successBlock: (() -> Void)?,
                   failureBlock: @escaping(RSBaseResponse) -> Void)
    {
        Networking.sharedInstance.loginUser(email: email, password: password, successBlock: { (succesfullResponse) in
            guard let token = succesfullResponse.userToken else {
                return
            }
            self.authToken = token
            self.userEmail = email
            self.isLoggedIn = true
            
            successBlock?()
        }) { (failureResponse) in
            failureBlock(failureResponse)
        }
    }
    
    func createUser(name: String,
                    email: String,
                    avatarName: String,
                    avatarColor: String,
                    successBlock: @escaping () -> Void,
                    failBlock: @escaping (RSBaseResponse) -> Void)
    {
        Networking.sharedInstance.createNewUser(name: name, email: email, avatarName: avatarName, avatarColor: avatarColor, sucessBlock: {
            successBlock()
        }) { (failureResponse) in
            failBlock(failureResponse)
        }
    }
    
    func findUserByEmail(_ email: String, completionBlock: @escaping (_ user: User) -> Void )
    {
        Networking.sharedInstance.findUserByEmail(email) { (user) in
            completionBlock(user)
        }
    }
    
    //MARK:- Helpers
    func resetData()
    {
        self.authToken = ""
        self.userEmail = ""
        self.isLoggedIn = false
    }
    
}
