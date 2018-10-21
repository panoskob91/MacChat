//
//  ModalCreateAccount.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 14/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class ModalCreateAccount: NSView {

    //MARK:- IBOutlets
    @IBOutlet var view: NSView!
    @IBOutlet var createAccountLabel: NSTextField!
    @IBOutlet var nameTextField: NSTextField!
    @IBOutlet var emailTextField: NSTextField!
    @IBOutlet var passwordTextField: NSSecureTextField!
    @IBOutlet var createAccountButton: NSButton!
    @IBOutlet var chooseImageButton: NSButton!
    @IBOutlet var profileImageButton: NSButton!
    @IBOutlet var progressSpinner: NSProgressIndicator!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "ModalCreateAccount"), owner: self, topLevelObjects: nil)
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
        setupSubViews()
    }
    
 
    func setupSubViews()
    {
        self.createAccountLabel.font = NSFont(name: AVENIR_BOLD, size: 15.0)
        self.createAccountLabel.textColor = lightGrayColor
        
        self.nameTextField.font = channelFont
        self.nameTextField.textColor = lightGrayColor
        self.nameTextField.focusRingType = NSFocusRingType.none
        self.nameTextField.nextKeyView = self.emailTextField
        self.nameTextField.isBordered = false
        
        self.emailTextField.font = channelFont
        self.emailTextField.textColor = lightGrayColor
        self.emailTextField.focusRingType = NSFocusRingType.none
        self.emailTextField.nextKeyView = self.passwordTextField
        self.emailTextField.isBordered = false
        
        self.passwordTextField.font = channelFont
        self.passwordTextField.textColor = lightGrayColor
        self.passwordTextField.focusRingType = NSFocusRingType.none
        self.passwordTextField.nextKeyView = self.nameTextField
        self.passwordTextField.isBordered = false
        
        self.profileImageButton.layer?.cornerRadius = 10
        self.profileImageButton.layer?.borderColor = NSColor.gray.cgColor
        self.profileImageButton.layer?.borderWidth = 3
        
        self.createAccountButton.setFont(loginFont)
        self.createAccountButton.setTitleColor(color: NSColor.white)
        let modalGreen = NSColor.createColor(red: 0, green: 153, blue: 51, alpha: 1.0)
        self.createAccountButton.layer?.backgroundColor = modalGreen.cgColor
        self.createAccountButton.layer?.cornerRadius = 4
        
        self.chooseImageButton.setFont(loginFont)
        self.chooseImageButton.setTitleColor(color: NSColor.white)
        self.chooseImageButton.layer?.backgroundColor = modalGreen.cgColor
        self.chooseImageButton.layer?.cornerRadius = 4
        
        self.progressSpinner.isHidden = true
        
    }
    
    //MARK:- IBActions
    @IBAction func closeModalButtonClicked(_ sender: NSButton)
    {
        NotificationCenter.default.post(name: NOTIF_CLOSE_MODAL, object: nil)
    }
    @IBAction func createAccountButtonClicked(_ sender: NSButton)
    {
        let registerFieldsArePopulated: Bool = (self.nameTextField.stringValue != "") && (self.emailTextField.stringValue != "") && (self.passwordTextField.stringValue != "")
        if (registerFieldsArePopulated)
        {
            AuthService.sharedInstance.registerUser(email: emailTextField.stringValue, password: passwordTextField.stringValue, successBlock: nil, failBlock: nil)
        }
        else
        {
            let button: NSButton = NSButton(title: "OK", target: self, action: nil)
            let alert: Alert = Alert(messageText: "Please populate above fields before procceding to registration", buttons: [button], alertStyle: NSAlert.Style.critical, icon: nil)
            alert.showAlert()
        }
        
    }
    @IBAction func chooseImageButtonClicked(_ sender: NSButton) {
    }
    
    
}
