//
//  NSString.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 16/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

extension String {
    
    func color() -> NSColor? {
        assert(self.hasPrefix("[") && self.hasSuffix("]") && self.isSeparetedBy(" ,"),
               "String provided does not have the correct format, it should be formated as [<red>, <green>, <blue>, <alpha>]")
        //Strip string from "[" "]"
        var strippedString = self.replacingOccurrences(of: "[", with: "")
        strippedString = strippedString.replacingOccurrences(of: "]", with: "")
        //Strip string to separate components
        let components = strippedString.components(separatedBy: ", ")
        
        let red = components[0].cgFloat()
        let green = components[1].cgFloat()
        let blue = components[2].cgFloat()
        let alpha = components[3].cgFloat()
        
        guard let redComponent = red,
              let greenComponent = green,
              let blueComponent = blue,
              let alphaComponent = alpha else {
              
                return nil
        }
        
        let color = NSColor(red: redComponent,
                            green: greenComponent,
                            blue: blueComponent,
                            alpha: alphaComponent)
        return color
    }
    
    func isSeparetedBy(_ inputString: String) -> Bool
    {
        let components = self.components(separatedBy: inputString)
        if (components.count == 0 && components[0] == self) {
            return false
        }
        return true
    }
    
    func cgFloat() -> CGFloat? {
        let numberFormater = NumberFormatter()
        numberFormater.decimalSeparator = "."
        guard let number = numberFormater.number(from: self) as? CGFloat else {
            return nil
        }
        return number
    }
    
}
