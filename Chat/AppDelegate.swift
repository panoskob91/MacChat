    //
//  AppDelegate.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 03/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
    }

    func applicationDidBecomeActive(_ notification: Notification) {
        SocketService.sharedInstance.establishConnection()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        SocketService.sharedInstance.closeConnection()
    }
    
    func applicationWillHide(_ notification: Notification) {
        UserDataService.sharedInstance.isHiding = true
    }

    func applicationWillUnhide(_ notification: Notification) {
        UserDataService.sharedInstance.isHiding = false
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

