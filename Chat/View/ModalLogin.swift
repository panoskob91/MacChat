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
    @IBOutlet var signInLabel: NSTextField!
    @IBOutlet var emailTextField: NSTextField!
    @IBOutlet var passwordTextField: NSSecureTextField!
    @IBOutlet var loginButton: NSButton!
    @IBOutlet var createAnAccountButton: NSButton!
    @IBOutlet var stackView: NSStackView!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalLogin"), owner: self, topLevelObjects: nil)
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
        self.view.frame = NSRect(x: 0, y: 0, width: 475, height: 300)
        self.view.layer?.backgroundColor = CGColor.white
        self.view.layer?.cornerRadius = 7
        
        self.signInLabel.alignment = .center
        self.signInLabel.textColor = NSColor.black
        self.signInLabel.font = NSFont(name: AVENIR_BOLD, size: loginFontSize)
        
        self.emailTextField.placeholderString = "Email"
        self.emailTextField.layer?.cornerRadius = 5
        self.emailTextField.textColor = NSColor.darkGray
        self.emailTextField.isBordered = false
        self.emailTextField.focusRingType = NSFocusRingType.none
        self.emailTextField.nextKeyView = self.passwordTextField
        
        self.passwordTextField.placeholderString = "Password"
        self.passwordTextField.layer?.cornerRadius = 5
        self.passwordTextField.textColor = NSColor.darkGray
        self.passwordTextField.isBordered = false
        self.passwordTextField.focusRingType = NSFocusRingType.none
        self.passwordTextField.nextKeyView = self.emailTextField
        
        let modalGreen = NSColor.createColor(red: 0, green: 153, blue: 51, alpha: 1.0)
        self.loginButton.layer?.backgroundColor = modalGreen.cgColor
        self.loginButton.title = "Log in"
        self.loginButton.font = loginFont
        self.loginButton.layer?.cornerRadius = 7
        self.loginButton.setTitleColor(color: NSColor.white)
        self.loginButton.isBordered = false
        
        self.createAnAccountButton.font = loginFont
        self.createAnAccountButton.title = "Create an account"
        self.createAnAccountButton.setTitleColor(color: modalGreen)
        self.createAnAccountButton.isBordered = false
    }
    
    //MARK:- IBActions
    @IBAction func closeModalClicked(_ sender: NSButton)
    {
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
        
    }
    @IBAction func createAccountButtonClicked(_ sender: NSButton)
    {
        let closeImediatelyDictionary: [String: Bool] = [USER_INFO_REMOVE_IMMEDIATELY: true]
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil, userInfo: closeImediatelyDictionary)
    }
    
    
}
