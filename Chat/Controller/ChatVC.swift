//
//  ChatVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ChatVC: NSViewController {

    @IBOutlet var chatTableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = chatColor.cgColor
        self.chatTableView.backgroundColor = chatColor
    }
    
}
