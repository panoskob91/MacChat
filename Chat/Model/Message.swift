//
//  Message.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 27/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class Message: NSObject {

    var messageBody: String!
    var user: User!
    var channel: Channel!
    var timeStamp: Date!
    var messageId: String!
    
    init(messageBody: String, user: User, channel: Channel, stamp: Date, messageId: String) {
        super.init()
        self.messageBody = messageBody
        self.user = user
        self.channel = channel
        self.timeStamp = stamp
        self.messageId = messageId
    }
    
}
