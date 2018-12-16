//
//  SplitView.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 16/12/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class SplitView: NSSplitView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override var dividerThickness: CGFloat {
        get {
            return 0.0
        }
    }
    
}
