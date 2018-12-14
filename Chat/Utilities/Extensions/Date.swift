//
//  Date.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 29/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa
extension Date {
    func string(_ dateFormat: String) -> String
    {
        let dateFormater = DateFormatter()
//        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormater.dateFormat = dateFormat
        let dateString = dateFormater.string(from: self)
        
        return dateString
    }
}

