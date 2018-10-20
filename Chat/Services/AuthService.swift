//
//  AuthService.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 20/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Foundation

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
        let lowercasedEmail = email.lowercased()
        let body: [String : Any] = ["email" : lowercasedEmail,
                                    "password" : password]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
//        let requestURL: URL = URL(string: REGISTER_URL)!
//        var request = URLRequest(url: requestURL, timeoutInterval: TIMEOUT_TIME)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = DEFAULT_HEADERS
//        request.httpBody = bodyData
        
//        let request = URLRequest.request(withURLString: REGISTER_URL, method: "POST", headers: DEFAULT_HEADERS, cachePolicy: nil, httpBody: bodyData)
        
        let request = URLRequest.request(withURLString: LOCAL_REGISTER_URL, method: "POST", headers: DEFAULT_HEADERS, cachePolicy: nil, httpBody: bodyData)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (responseData, response, error) in
            guard let data = responseData else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            print(json)
        }
        dataTask.resume()
        
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
