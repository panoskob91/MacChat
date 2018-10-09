//
//  ToolbarVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ToolbarVC: NSViewController {

    //MARK:- IBOutlets
    @IBOutlet var userAvatar: NSImageView!
    @IBOutlet var loginLabel: NSTextField!
    @IBOutlet var loginStackView: NSStackView!
    
    
    //MARK:- ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = toolbarColor.cgColor
        self.loginLabel.setFont(loginFont, textColor: grayTextColor)
        
        self.loginStackView.gestureRecognizers.removeAll()
        let profilePage = NSClickGestureRecognizer(target: self, action: #selector(ToolbarVC.openProfilePage))
        self.loginStackView.addGestureRecognizer(profilePage)
    }
    
    @objc func openProfilePage(_ recogniser: NSClickGestureRecognizer)
    {
        print("Open profile page")
    }
    
}
