//
//  ToolbarVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ToolbarVC: NSViewController {

    
    @IBOutlet var userAvatar: NSImageView!
    @IBOutlet var loginLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = toolbarColor.cgColor
        setupLoginLabel()
    }

    func setupLoginLabel()
    {
        self.loginLabel.textColor = loginLabelColor
        self.loginLabel.font = NSFont(name: "Avenir Next Regular", size: 15)
    }
    
}
