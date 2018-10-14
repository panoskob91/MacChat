//
//  ModalLogin.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 14/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ModalLogin: NSView {

    //MARK:- IBOutlets
    @IBOutlet weak var view: NSView!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalLogin"), owner: self, topLevelObjects: nil)
        self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
        self.addSubview(self.view)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        setupView()
    }
    
    func setupView()
    {
        self.view.layer?.backgroundColor = CGColor.white
        self.view.layer?.cornerRadius = 7
    }
}
