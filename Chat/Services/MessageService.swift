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
    var messages: [Message] = []
    
    //MARK: -  Networking methods
    
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
    
    func findAllMessages(_ channel: Channel,
                         successBlock: @escaping([Message]?) -> Void,
                         failureBlock: @escaping(RSBaseResponse?) -> Void)
    {
        Networking.sharedInstance.findAllMessagesForChannel(channel, successBlock: { (messages) in
            guard let messageArray = messages else {
                failureBlock(nil)
                return
            }
            self.messages = messageArray
            successBlock(messages)
        }) { (failureResponse) in
            failureBlock(failureResponse)
        }
    }
    
    func emptyChannels()
    {
        self.channels = []
    }
    
    func clearMessages() {
        self.messages.removeAll()
    }
}
