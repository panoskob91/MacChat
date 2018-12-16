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
        guard let cName = channel.channelName,
            let cDescription = channel.channelDescription else {
            return
        }
        
        socket?.emit("newChannel", cName, cDescription)
        completionBlock?()
    }
    
    func getChatMessage(_ completionBlock: @escaping (_ newMessage: Message) -> Void) {
        socket?.on("messageCreated", callback: { (dataArray, socketAck) in
            guard let messageBody = dataArray[0] as? String,
                let userId = dataArray[1] as? String,
                let channelId = dataArray[2] as? String,
                let userName = dataArray[3] as? String,
                let userAvatarName = dataArray[4] as? String,
                let userAvatarColor = dataArray[5] as? String,
                let messageId = dataArray[6] as? String,
                let timeStamp = dataArray[7] as? String
            else {
                return
            }
            let user = User(id: userId,
                            name: userName,
                            email: nil,
                            avatarName: userAvatarName,
                            avatarColor: userAvatarColor)
            let channel = Channel(channelName: nil, channelId: channelId, description: nil)
            guard let timeStampDate = timeStamp.date() else {
                return
            }
            let newMessage = Message(messageBody: messageBody,
                                  user: user,
                                  channel: channel,
                                  stamp: timeStampDate,
                                  messageId: messageId)
            completionBlock(newMessage)
        })
    }
}
