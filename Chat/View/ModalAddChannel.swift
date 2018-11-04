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
    @IBOutlet var addChannel: NSTextField!
    @IBOutlet var stackView: NSView!
    @IBOutlet var addChannelButton: NSButton!
    @IBOutlet var channelName: NSTextField!
    @IBOutlet var channelDescription: NSTextField!
    
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
    
    func setupView()
    {
        self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
        self.view.layer?.backgroundColor = CGColor.white
        self.view.layer?.cornerRadius = 7
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
        //Channel description
        self.channelDescription.placeholderString = "Channel description"
        self.channelDescription.font = NSFont(name: AVENIR_REGULAR, size: 12)
        self.channelDescription.textColor = NSColor.black
        self.channelDescription.nextKeyView = channelName
        
    }
    //MARK:- IBActions
    @IBAction func descriptionFieldEnterPressed(_ sender: NSTextField)
    {
        addChannelButton.performClick(nil)
    }
    
    @IBAction func addNewChannelButtonPressed(_ sender: NSButton)
    {
        
    }
    
}
