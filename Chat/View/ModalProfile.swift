//
//  ModalProfile.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 03/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ModalProfile: NSView {
    //MARK:- IBOutlets
    @IBOutlet weak var view: NSView!
    @IBOutlet private var titleLabel: NSTextField!
    @IBOutlet private var usernameLabel: NSTextField!
    @IBOutlet private var emailLabel: NSTextField!
    @IBOutlet private var profileImage: NSImageView!
    @IBOutlet private var logoutButton: NSButton!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalProfile"), owner: self, topLevelObjects: nil)
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
        
        self.titleLabel.stringValue = "Profile"
        self.titleLabel.setFont(NSFont(name: AVENIR_BOLD, size: 19)!,
                                textColor: grayTextColor)
        //username
        self.usernameLabel.stringValue = UserDataService.sharedInstance.name
        
        //email
        self.emailLabel.stringValue = UserDataService.sharedInstance.email
        
        //Profile image
        self.profileImage.layer?.cornerRadius = 10
        self.profileImage.layer?.borderColor = NSColor.gray.cgColor
        self.profileImage.layer?.borderWidth = 3
        self.profileImage.image = NSImage(named: NSImage.Name(UserDataService.sharedInstance.avatarName))
        let profileBackgroundColor = UserDataService.sharedInstance.avatarColor.color()
        self.profileImage.layer?.backgroundColor = profileBackgroundColor?.cgColor
        
        let modalGreen = NSColor.createColor(red: 0,
                                             green: 153,
                                             blue: 51,
                                             alpha: 1.0)
        self.logoutButton.title = "Log out"
        self.logoutButton.layer?.cornerRadius = 5
        self.logoutButton.setTitleColor(color: NSColor.white)
        self.logoutButton.layer?.backgroundColor = modalGreen.cgColor
        self.logoutButton.isBordered = false
    }
    
    //MARK:- IBActions
    @IBAction private func closeModalClicked(_ sender: NSButton) {
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
    }
    
    @IBAction func logoutClicked(_ sender: NSButton) {
        UserDataService.sharedInstance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
        
    }
    
}
