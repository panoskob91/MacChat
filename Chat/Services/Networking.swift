//
//  Networking.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 21/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class Networking: NSObject, HTTPRequestsProtocol
{
 
    static let sharedInstance: Networking = Networking()
    
    private func requestRegisterUser(email eMail: String,
                                     password passWord: String,
                                     success: @escaping(_ response: RSBaseResponse) -> Void,
                                     failure: @escaping(_ error: RSBaseResponse) -> Void)
    {
        let body = ["email" : eMail,
                    "password" : passWord]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        //TODO - set heroku url
//        let request = URLRequest.request(withURLString: REGISTER_URL, method: "POST", headers: DEFAULT_HEADERS, cachePolicy: nil, httpBody: bodyData)
        let request = URLRequest.request(withURLString: LOCAL_REGISTER_URL, method: "POST", headers: DEFAULT_HEADERS, cachePolicy: nil, httpBody: bodyData)
        let dataTask = URLSession.shared.dataTask(with: request) { (responseData, response, responseError) in
            guard let serverResponse = response as? HTTPURLResponse else {
                return
            }
            guard let data = responseData else {
                return
            }
            var JSONResponse: [String : Any]?
            
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            JSONResponse = json as? [String : Any]
            
            let baseResponse: RSBaseResponse = RSBaseResponse(responseObject: serverResponse,
                                                              jsonResponse: JSONResponse,
                                                              networkError: responseError)
            //If there is an error call fail block
            //Else call success block
            if (responseError == nil && JSONResponse == nil)
            {
                success(baseResponse)
            }
            else
            {
                failure(baseResponse)
            }
        }
        dataTask.resume()
    }
    
    private func requestUserLogin(email: String,
                                  password: String,
                                  success: @escaping(LoginResponse) -> Void,
                                  failure: @escaping(RSBaseResponse) -> Void)
    {
        let lowerCaseEmail = email.lowercased()
        let body: [String : Any] = ["email" : lowerCaseEmail,
                                    "password": password]
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        //        let request = URLRequest.request(withURLString: LOGIN_URL, method: "POST", headers: DEFAULT_HEADERS, cachePolicy: nil, httpBody: bodyData)
        let request = URLRequest.request(withURLString: LOCAL_LOGIN_URL,
                                         method: "POST",
                                         headers: DEFAULT_HEADERS,
                                         cachePolicy: nil,
                                         httpBody: bodyData)
        let dataTask = URLSession.shared.dataTask(with: request) { (responseData, response, responseError) in
            guard let serverResponse = response as? HTTPURLResponse else {
                return
            }
            guard let jsonData = responseData else {
                return
            }
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
            guard let json = jsonObject as? [String : Any] else {
                return
            }
            
            let errorMessage = json["message"] as? String
            let baseResponse: RSBaseResponse = RSBaseResponse(responseObject: serverResponse, jsonResponse: json, networkError: responseError)
            
            guard let userEmail = json["user"] as? String else {
                failure(baseResponse)
                return
            }
            
            guard let userToken = json["token"] as? String else {
                failure(baseResponse)
                return
            }
            
            let loginResponse: LoginResponse = LoginResponse(userEmail: userEmail, userToken: userToken)
            
            if (responseError != nil || errorMessage != nil)
            {
                failure(baseResponse)
            }
            else
            {
                success(loginResponse)
            }
            
        }
        dataTask.resume()
    }
    
    private func createUser(name: String,
                            email: String,
                            avatarName: String,
                            avatarColor: String,
                            completionBlock: @escaping () -> Void)
    {
     
        let lowerCaseEmail = email.lowercased()
        let body: [String : Any] = ["name" : name,
                                    "email":lowerCaseEmail,
                                    "avatarName": avatarName,
                                    "avatarColor" : avatarColor]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body)
        
        let headers = ["Authorization" : "Bearer \(AuthService.sharedInstance.authToken)",
                       "Content-Type" : "application/json; charset=utf-8"]
        //        let request = URLRequest.request(withURLString: USER_ADD_URL  , method: "POST", headers: DEFAULT_HEADERS, cachePolicy: nil, httpBody: bodyData)
        let request = URLRequest.request(withURLString: LOCAL_USER_ADD_URL,
                                         method: "POST",
                                         headers: headers,
                                         cachePolicy: nil,
                                         httpBody: bodyData)
        let dataTask = URLSession.shared.dataTask(with: request) { (responseData, response, responseError) in
       
            guard let jsonData = responseData else {
                return
            }
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
            guard let json = jsonObject as? [String : Any] else {
                return
            }
            
            guard let userId = json["_id"] as? String else {
                return
            }
            guard let name = json["name"] as? String else {
                return
            }
            guard let email = json["email"] as? String else {
                return
            }
            guard let avatarName = json["avatarName"] as? String else {
                return
            }
            guard let avatarColor = json["avatarColor"] as? String else {
                return
            }
            
            UserDataService.sharedInstance.id = userId
            UserDataService.sharedInstance.name = name
            UserDataService.sharedInstance.email = email
            UserDataService.sharedInstance.avatarName = avatarName
            UserDataService.sharedInstance.avatarColor = avatarColor
            completionBlock()
            
        }
        dataTask.resume()
        
    }
    
    //MARK:- Protocol functions
    func registerUser(email eMail: String,
                      password passWord: String,
                      success: @escaping (RSBaseResponse) -> Void,
                      failure: @escaping (RSBaseResponse) -> Void) {
        requestRegisterUser(email: eMail, password: passWord, success: { (successResponse) in
            success(successResponse)
        }) { (failureResponse) in
            failure(failureResponse)
        }
    }
    
    func loginUser(email: String,
                   password: String,
                   successBlock: @escaping (LoginResponse) -> Void,
                   failureBlock: @escaping (RSBaseResponse) -> Void)
    {
        requestUserLogin(email: email, password: password, success: { (succesResponse) in
            successBlock(succesResponse)
        }) { (failureResponse) in
            failureBlock(failureResponse)
        }
    }
    
    func createNewUser(name: String,
                       email: String,
                       avatarName: String,
                       avatarColor: String,
                       completionBlock: @escaping () -> Void)
    {
        createUser(name: name, email: email, avatarName: avatarName, avatarColor: avatarColor) {
            completionBlock()
        }
    }
}
