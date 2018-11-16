//
//  NSColor.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

extension NSColor {
    class func createColor(red rColor: CGFloat, green gColor: CGFloat, blue bColor: CGFloat, alpha a: CGFloat) -> NSColor
    {
        let red = rColor / 255
        let green = gColor / 255
        let blue = bColor / 255
        
        let color = NSColor(calibratedRed: red, green: green, blue: blue, alpha: a)
        return color
    }
    
    /// Function for creating a string representation of an NSColor object to store colors to dataBase, and be able to decode
    ///
    /// - Returns: String (with format: ["red", "green", "blue", "alpha"])
    func string() -> String {
        let redComponent = self.redComponent
        let greenComponent = self.greenComponent
        let blueComponent = self.blueComponent
        let alphaComponent = self.alphaComponent
        
        return "[\(redComponent), "
                + "\(greenComponent), "
                + "\(blueComponent), "
                + "\(alphaComponent)]"
    }
}
