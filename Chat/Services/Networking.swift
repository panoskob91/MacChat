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
    
}
