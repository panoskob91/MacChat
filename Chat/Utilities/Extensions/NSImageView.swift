//
//  NSImageView.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 30/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa
import AppKit

extension NSImageView
{
    func setGestureRecogniser(gestureRecogniser: NSGestureRecognizer)
    {
        self.addGestureRecognizer(gestureRecogniser)
    }
}
