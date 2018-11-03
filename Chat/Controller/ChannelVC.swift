//
//  ChannelVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ChannelVC: NSViewController {

    //MARK:- IBOutlets
    @IBOutlet private var channelsTableView: NSTableView!
    @IBOutlet private var channelsLabel: NSTextField!
    @IBOutlet private var usernameLabel: NSTextField!
    @IBOutlet private var addChannelButton: NSButton!
    
    //MARK:- ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChannelButton.isBordered = false
        setupView()
        startObservingForNotifications()
        
    }
    //MARK:- Helper functions
    private func setupView()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = channelColor.cgColor
        //labels
        self.channelsLabel.setFont(channelFont, textColor: grayTextColor)
        self.usernameLabel.setFont(channelFont, textColor: grayTextColor)
        self.usernameLabel.stringValue = ""
        //Buttons
        self.addChannelButton.setFont(channelFont)
        self.addChannelButton.setTitleColor(color: grayTextColor)
        //TableView
        self.channelsTableView.backgroundColor = channelColor
        
    }

    private func startObservingForNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
    }
    
    @objc private func userDataDidChange(_ notif: Notification)
    {
        if (AuthService.sharedInstance.isLoggedIn)
        {
            usernameLabel.stringValue = UserDataService.sharedInstance.name
        }
        else
        {
            usernameLabel.stringValue = ""
        }
    }
    
    //MARK: - IBActions
    @IBAction private func addChanelButtonClicked(_ sender: NSButton)
    {
        
    }
    
    
}
