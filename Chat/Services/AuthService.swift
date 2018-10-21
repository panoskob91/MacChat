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
    
    func registerUser(email: String, password: String, completion: @escaping ()->Void)
    {
        Networking.sharedInstance.registerUser(email: email, password: password, success: { (successResponse) in
            print(successResponse)
            
        }) { (failureResponse) in
            guard let messageDictionary = failureResponse.responseObject?["message"] as? [String : String] else {
                return
            }
            guard let alertMessage = messageDictionary["message"] else {
                return
            }
            
            DispatchQueue.main.async {
                let button: NSButton = NSButton(title: "OK", target: self, action: nil)
                let alert: Alert = Alert(messageText: alertMessage, buttons: [button], icon: nil)
                alert.showAlert()
            }
        }
    }
    
    func loginUser(email: String, password: String,  completionBlock: @escaping() -> Void)
    {
        let lowerCaseEmail = email.lowercased()
        let body = ["email" : lowerCaseEmail,
                    "password" : password]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        
//        var request = URLRequest(url: <#T##URL#>, cachePolicy: <#T##URLRequest.CachePolicy#>, timeoutInterval: <#T##TimeInterval#>)
    }
    
}
