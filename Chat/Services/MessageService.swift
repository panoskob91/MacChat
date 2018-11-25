//
//  MessageService.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 20/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class MessageService: NSObject {

    static let sharedInstance: MessageService = MessageService()
    var channels: [Channel] = []
    
    func findAllChannels(sBlock: @escaping([Channel]?) -> Void,
                         fBlock: @escaping(RSBaseResponse?) -> Void)
    {
        Networking.sharedInstance.findAllChannels(succesBlock: { (channels) in
            self.channels = channels
            sBlock(channels)
        }) { (failureResponse) in
            fBlock(failureResponse)
        }
    }
    
    func emptyChannels()
    {
        self.channels = []
    }
}
