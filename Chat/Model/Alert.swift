//
//  Alert.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 21/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class Alert: NSAlert
{
    var alertIcon: NSImage?
    let alertButtons: [NSButton]
    let message: String
    
    init(messageText text: String,
         buttons btns: [NSButton],
         alertStyle aStyle: NSAlert.Style = NSAlert.Style.warning,
         icon image: NSImage?)
    {
        self.message = text
        self.alertIcon = image
        self.alertButtons = btns
        super.init()
        self.alertStyle = aStyle
        
    }
    
    func showAlert()
    {
        self.messageText = self.message
        addButtons(self.alertButtons)
        self.runModal()
    }
    
    private func addButtons(_ inputButtons: [NSButton])
    {
        for alertButton in inputButtons {
            addButton(withTitle: alertButton.title)
        }
    }
    
}
