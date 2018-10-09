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
    @IBOutlet var channelsTableView: NSTableView!
    @IBOutlet var channelsLabel: NSTextField!
    @IBOutlet var usernameLabel: NSTextField!
    @IBOutlet var addChannelButton: NSButton!
    
    //MARK:- ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChannelButton.isBordered = false
        setupView()
        
    }
    //MARK:- Helper functions
    func setupView()
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

    @IBAction func addChanelButtonClicked(_ sender: NSButton)
    {
        
    }
    
    
}
