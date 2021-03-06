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
let lightGrayColor = NSColor.createColor(red: 153, green: 153, blue: 153, alpha: 1.0)


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


//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//API Urls
let BASE_URL = "https://mac-chat-app.herokuapp.com/v1/"
let LOCAL_BASE_URL = "http://localhost:3005/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOCAL_REGISTER_URL = "\(LOCAL_BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let LOCAL_LOGIN_URL = "\(LOCAL_BASE_URL)account/login"
let USER_ADD_URL = "\(BASE_URL)user/add"
let LOCAL_USER_ADD_URL = "\(LOCAL_BASE_URL)user/add"



//Networking constants
let TIMEOUT_TIME: Double = 120.0


//Headers
let DEFAULT_HEADERS = ["Content-Type" : "application/json; charset=utf-8"]
