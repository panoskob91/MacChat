//
//  SocketService.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 04/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa
import SocketIO

class SocketService: NSObject {
    static let sharedInstance: SocketService = SocketService()
    
    private var manager = SocketManager(socketURL: URL(string: LOCAL_BASE_URL)!)
    var socket: SocketIOClient?
    
    override init() {
        super.init()
        socket = manager.defaultSocket
    }
    
    func establishConnection()
    {
        socket?.connect()
    }
    
    func closeConnection()
    {
        socket?.disconnect()
    }
    
    func addMessage(_ messageBody: String, user: User, channel: Channel , completionBlock: @escaping () -> Void)
    {
        socket?.emit("newMessage", messageBody, user.userID, channel.channelId , user.userName, user.avatarName, user.avatarColor)
        completionBlock()
    }
    
    func addChannel(channel: Channel, completionBlock: (() -> Void)?)
    {
        socket?.emit("newChannel", channel.channelName, channel.channelDescription)
        completionBlock?()
    }
    
}
