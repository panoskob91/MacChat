//
//  ModalAddChannel.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 04/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ModalAddChannel: NSView {

    @IBOutlet weak var view: NSView!
    @IBOutlet private var addChannel: NSTextField!
    @IBOutlet private var stackView: NSView!
    @IBOutlet private var addChannelButton: NSButton!
    @IBOutlet private var channelName: NSTextField!
    @IBOutlet private var channelDescription: NSTextField!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalAddChannel"), owner: self, topLevelObjects: nil)
        self.addSubview(self.view)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setupView()
    }
    
    private func setupView()
    {
        self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
        self.view.layer?.backgroundColor = CGColor.white
        self.view.layer?.cornerRadius = 7
        setupUI()
        
    }
    
    private func setupUI()
    {
        //Add channel label setup
        self.addChannel.font = NSFont(name: AVENIR_BOLD, size: 19)
        self.addChannel.textColor = grayTextColor
        self.addChannel.stringValue = "Add channel"
        //Add channel button
        let modalGreen = NSColor.createColor(red: 0, green: 153, blue: 51, alpha: 1.0)
        self.addChannelButton.layer?.backgroundColor = modalGreen.cgColor
        self.addChannelButton.title = "Add channel"
        self.addChannelButton.font = loginFont
        self.addChannelButton.layer?.cornerRadius = 5
        self.addChannelButton.setTitleColor(color: NSColor.white)
        self.addChannelButton.isBordered = false
        //Channel name
        self.channelName.placeholderString = "Channel name"
        self.channelName.font = NSFont(name: AVENIR_REGULAR, size: 12)
        self.channelName.textColor = NSColor.black
        self.channelName.nextKeyView = self.channelDescription
        self.channelName.isBordered = false
        self.channelName.focusRingType = NSFocusRingType.none
        //Channel description
        self.channelDescription.placeholderString = "Channel description"
        self.channelDescription.font = NSFont(name: AVENIR_REGULAR, size: 12)
        self.channelDescription.textColor = NSColor.black
        self.channelDescription.nextKeyView = channelName
        self.channelDescription.isBordered = false
        self.channelDescription.focusRingType = NSFocusRingType.none
    }
    
    //MARK:- IBActions
    @IBAction private func descriptionFieldEnterPressed(_ sender: NSTextField)
    {
        addChannelButton.performClick(nil)
    }
    
    @IBAction private func closeModal(_ sender: NSButton)
    {
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
    }
    
    @IBAction private func addNewChannelButtonPressed(_ sender: NSButton)
    {
        let channel = Channel(channelName: self.channelName.stringValue,
                              channelId: "12345",//Dummy id
                              description: self.channelDescription.stringValue)
        SocketService.sharedInstance.addChannel(channel: channel) {
            NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
        }
    }
    
}
