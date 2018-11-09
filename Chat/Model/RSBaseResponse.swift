//
//  RSBaseResponse.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 21/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class RSBaseResponse: NSObject
{
    let statusCode: Int
    let responseHeaders: [String : Any]
    let responseObject: [String : Any]?
    let networkError: Error?
    
    override var description: String {
        get {
            let dResponseObject = self.responseObject ?? nil
            let dNetworkError = self.networkError ?? nil
            let returnedString = "status code: \(self.statusCode)"
                + "response headers: \(self.responseHeaders)"
                + "response object: \(String(describing: dResponseObject))"
                + "network error: \(String(describing: dNetworkError))"
            
            return returnedString
        }
    }
    
    init(statusCode code: Int, responseHeaders headers: [String : Any], responseObject json: [String : Any]?, error: Error?) {
        self.statusCode = code
        self.responseHeaders = headers
        self.responseObject = json
        self.networkError = error
    }
    init(responseObject rObj: HTTPURLResponse, jsonResponse: [String : Any]?, networkError: Error?) {
        self.statusCode = rObj.statusCode
        self.responseHeaders = rObj.allHeaderFields as! [String : Any]
        self.responseObject = jsonResponse
        self.networkError = networkError
    }
}
