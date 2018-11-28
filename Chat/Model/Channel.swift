//
//  Channel.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 04/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class Channel: NSObject {

    var channelName: String?
    var channelId: String!
    var channelDescription: String?
    
    init(channelName: String?, channelId: String, description: String?) {
        self.channelName = channelName
        self.channelId = channelId
        self.channelDescription = description
    }
    
}
