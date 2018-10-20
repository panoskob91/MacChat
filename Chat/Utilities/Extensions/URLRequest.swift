//
//  URLRequest.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 20/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Foundation

extension URLRequest
{
    static func request(withURLString urlString: String,
                       method httpMethod: String,
                       headers: [String : String],
                       timeoutTime time: Double = TIMEOUT_TIME,
                       cachePolicy cPolicy:URLRequest.CachePolicy?,
                       httpBody: Data?) -> URLRequest
    {
        let requestURL = URL(string: urlString)!
        var request: URLRequest
        guard let cacheP = cPolicy else {
            request = URLRequest(url: requestURL, timeoutInterval: time)
            request.httpMethod = httpMethod
            request.allHTTPHeaderFields = headers
            if let body = httpBody {
                request.httpBody = body
            }
            return request
        }
        request = URLRequest(url: requestURL, cachePolicy: cacheP, timeoutInterval: time)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        if let body = httpBody {
            request.httpBody = body
        }
        return request
    }
}
