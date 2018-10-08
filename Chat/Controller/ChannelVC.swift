//
//  ChannelVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ChannelVC: NSViewController {

    
    @IBOutlet var channelsTableView: NSTableView!
    @IBOutlet var channelsLabel: NSTextField!
    @IBOutlet var usernameLabel: NSTextField!
    @IBOutlet var addChannelButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView()
        
    }
    //MARK:- Helper functions
    func setupTableViewStyle()
    {
        self.channelsTableView.backgroundColor = channelColor
    }
    
    func setupChannelsLabelStyle()
    {
        self.channelsLabel.textColor = grayTextColor
        self.channelsLabel.font = NSFont(name: avenirFont, size: channelFontSize)
        
    }
    
    func setupAddButtonStyle()
    {
        self.addChannelButton.font = NSFont(name: avenirFont, size: channelFontSize)
        self.addChannelButton.isBordered = false
        
        self.addChannelButton.setTitleColor(color: grayTextColor)
    }
    
    func drawView()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = channelColor.cgColor
        
        setupChannelsLabelStyle()
        setupTableViewStyle()
        setupAddButtonStyle()
    }
    
}
