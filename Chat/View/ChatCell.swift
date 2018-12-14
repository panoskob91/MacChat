//
//  ChatCell.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 29/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ChatCell: NSTableCellView {

    @IBOutlet private var profileImageView: NSImageView!
    @IBOutlet private var userNameLabel: NSTextField!
    @IBOutlet private var timeStampLabel: NSTextField!
    @IBOutlet private var messageBodyLabel: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setupViews()
    }
    
    private func setupViews()
    {
        self.profileImageView.layer?.cornerRadius = 6
        self.profileImageView.layer?.borderColor = NSColor.gray.cgColor
        self.profileImageView.layer?.borderWidth = 2
    }
    
    func configureCell(_ message: Message)
    {
        self.messageBodyLabel.stringValue = message.messageBody
        self.userNameLabel.stringValue = message.user.userName
        self.profileImageView.wantsLayer = true
        self.profileImageView.image = NSImage(named: NSImage.Name(rawValue: message.user.avatarName))
        var backgroundColor = NSColor.gray
        if UserDataService.sharedInstance.avatarColor != "" {
            if let color = UserDataService.sharedInstance.avatarColor.color() {
                backgroundColor = color
            }
        }
        self.profileImageView.layer?.backgroundColor = backgroundColor.cgColor
        self.timeStampLabel.stringValue = message.timeStamp.string("dd MMMM yyyy")
    }
    
    class func getCellIdentifier() -> String {
        return "ChatCell"
    }
    
}
