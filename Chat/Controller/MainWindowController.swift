
//
//  MainWindowController.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.minSize = NSSize(width: 950, height: 600)
        self.window?.titlebarAppearsTransparent = true
        self.window?.titleVisibility = .hidden
        self.window?.delegate = self
    }
    
    func windowWillMiniaturize(_ notification: Notification) {
        UserDataService.sharedInstance.isMinimizing = true
    }
    
    func windowDidDeminiaturize(_ notification: Notification) {
        UserDataService.sharedInstance.isMinimizing = false
    }
}
