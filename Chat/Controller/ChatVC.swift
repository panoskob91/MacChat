//
//  ChatVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ChatVC: NSViewController {

    //MARK:- IBOutlets
    @IBOutlet var chatTableView: NSTableView!
    @IBOutlet var channelTitle: NSTextField!
    @IBOutlet var channeDescription: NSTextField!
    @IBOutlet var userTypingLabel: NSTextField!
    @IBOutlet var messageOutlineView: NSView!
    @IBOutlet var messageText: NSTextField!
    @IBOutlet var sendMessageButton: NSButton!
    
    //MARK:- ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear() {
        setupView()
    }
    
    //MARK:- Helper methods
    func setupView()
    {
        self.view.wantsLayer = true
        //        self.view.layer?.backgroundColor = chatColor.cgColor
        self.view.layer?.backgroundColor = nearlyWhiteColor.cgColor
        self.chatTableView.backgroundColor = nearlyWhiteColor
        
        self.messageOutlineView.wantsLayer = true
        self.messageOutlineView.layer?.backgroundColor = CGColor.white
        self.messageOutlineView.layer?.borderColor = NSColor.controlHighlightColor.cgColor
        self.messageOutlineView.layer?.borderWidth = 2
        self.messageOutlineView.layer?.cornerRadius = 5
        
        self.messageText.isBordered = false
        self.messageText.placeholderString = "Message"
        
        self.sendMessageButton.setTitleColor(color: NSColor.black)
        self.sendMessageButton.setFont(loginFont)
        
    }
    
    //MARK:- IBActions
    @IBAction func sendMessageButtonClicked(_ sender: NSButton)
    {
        
    }
    
    
}
