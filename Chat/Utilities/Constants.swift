//
//  Constants.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

//Colors
let toolbarColor = NSColor.createColor(red: 0, green: 102, blue: 255, alpha: 1.0)
let chatColor = NSColor.createColor(red: 230, green: 230, blue: 230, alpha: 1.0)
let nearlyWhiteColor = NSColor.createColor(red: 250, green: 250, blue: 250, alpha: 1.0)
let channelColor = NSColor.createColor(red: 179, green: 0, blue: 71, alpha: 1.0)
let grayTextColor = NSColor.createColor(red: 204, green: 204, blue: 204, alpha: 1.0)

//Fonts
let AVENIR_REGULAR = "AvenirNext-Regular"
let AVENIR_BOLD = "AvenirNext-Bold"
let loginFontSize: CGFloat = 15.0
let channelFontSize: CGFloat = 13.0
let channelFont = NSFont(name: AVENIR_REGULAR, size: channelFontSize)!
let loginFont = NSFont(name: AVENIR_REGULAR, size: loginFontSize)!

//Notifications Constants
let USER_INFO_MODAL = "modalUserInfo"
//let NOTIF_PRESENT_MODAL = Notification.Name["presentModal"]
let NOTIF_PRESENT_MODAL = Notification.Name(rawValue: "presentModal")
let NOTIF_CLOSE_MODAL = Notification.Name(rawValue: "closeModal")
let USER_INFO_REMOVE_IMMEDIATELY = "modalRemoveImmediately"
