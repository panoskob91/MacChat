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
        
    }
    //MARK:- Helper functions
    private func setupView()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = channelColor.cgColor
        //labels
        self.channelsLabel.setFont(channelFont, textColor: grayTextColor)
        self.usernameLabel.setFont(channelFont, textColor: grayTextColor)
        //Buttons
        self.addChannelButton.setFont(channelFont)
        self.addChannelButton.setTitleColor(color: grayTextColor)
        //TableView
        self.channelsTableView.backgroundColor = channelColor
        
    }

    @IBAction private func addChanelButtonClicked(_ sender: NSButton)
    {
        
    }
    
    
}
