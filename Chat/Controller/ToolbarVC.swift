//
//  ToolbarVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ToolbarVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = toolbarColor.cgColor
    }
    
}
