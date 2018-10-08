//
//  NSButton.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

extension NSButton
{
    func setTitleColor(color bColor: NSColor)
    {
        let attributedTitle = NSMutableAttributedString(attributedString: self.attributedTitle)
        let titleLength = attributedTitle.length
        let range = NSMakeRange(0, titleLength)
        attributedTitle.addAttributes([NSAttributedStringKey.foregroundColor : bColor], range: range)
        self.attributedTitle = attributedTitle
    }
    
    func getTitleColor() -> NSColor?
    {
        let  attributedTitle = self.attributedTitle
        let attributes = attributedTitle.fontAttributes(in: NSMakeRange(0, 1))
        
        guard let tColor = attributes[NSAttributedStringKey.foregroundColor] as? NSColor else {
            return nil
        }
        
        return tColor
        
    }
}
