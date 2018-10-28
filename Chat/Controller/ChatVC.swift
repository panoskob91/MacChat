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
    @IBOutlet private var chatTableView: NSTableView!
    @IBOutlet private var channelTitle: NSTextField!
    @IBOutlet private var channeDescription: NSTextField!
    @IBOutlet private var userTypingLabel: NSTextField!
    @IBOutlet private var messageOutlineView: NSView!
    @IBOutlet private var messageText: NSTextField!
    @IBOutlet private var sendMessageButton: NSButton!
    
    //MARK:- ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear() {
        setupView()
    }
    
    //MARK:- Helper methods
    private func setupView()
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
    @IBAction private func sendMessageButtonClicked(_ sender: NSButton)
    {
        
    }
    
    
}
