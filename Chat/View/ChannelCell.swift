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
    
    
    func configureCell(channel: Channel)
    {
        guard let userChannelName = channel.channelName else {
            return
        }
        self.channelName.stringValue = "#\(userChannelName)"
        self.channelName.font = NSFont(name: AVENIR_BOLD, size: 13.0)
    }
}
