//
//  ChannelCell.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 25/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ChannelCell: NSTableCellView {
    //MARK:- IBOutlets
    @IBOutlet var channelName: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    func configureCell(channel: Channel, selectedChannelIndex: Int, row: Int)
    {
        guard let userChannelName = channel.channelName else {
            return
        }
        self.channelName.stringValue = "#\(userChannelName)"
        self.channelName.font = NSFont(name: AVENIR_BOLD, size: 13.0)
        
        self.wantsLayer = true
        if row == selectedChannelIndex {
            self.layer?.backgroundColor = toolbarColor.cgColor
            self.channelName.textColor = NSColor.white
        }else {
            self.layer?.backgroundColor = CGColor.clear
            self.channelName.textColor = NSColor.controlColor
        }
    }
}
