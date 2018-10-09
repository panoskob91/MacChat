//
//  ToolbarVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 08/10/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

enum ModalType {
    case login
    
}

class ToolbarVC: NSViewController {

    //MARK:- IBOutlets
    @IBOutlet var userAvatar: NSImageView!
    @IBOutlet var loginLabel: NSTextField!
    @IBOutlet var loginStackView: NSStackView!
    
    //MARK:- Variables
    var modalBGView: ClickBlockingView!
    
    
    //MARK:- ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        startObservingForNotifications()
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
    
    func startObservingForNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.presentModal(_:)), name: NOTIF_PRESENT_MODAL, object: nil)
    }
    
    @objc func openProfilePage(_ recogniser: NSClickGestureRecognizer)
    {
        let loginDict: [String : ModalType] = [USER_INFO_MODAL : ModalType.login]
        NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: loginDict)
        
    }
    
    @objc func presentModal(_ notif: Notification)
    {
        if (self.modalBGView == nil)
        {
            self.modalBGView = ClickBlockingView()
            self.modalBGView.wantsLayer = true
            self.modalBGView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.modalBGView, positioned: NSWindow.OrderingMode.above, relativeTo: self.loginStackView)
            
            let topConstraint = NSLayoutConstraint(item: self.modalBGView, attribute: .top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 50)
            let leftConstraint = NSLayoutConstraint(item: self.modalBGView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
            let rightConstraint = NSLayoutConstraint(item: self.modalBGView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: self.modalBGView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
            
            self.view.addConstraints([topConstraint, leftConstraint, rightConstraint, bottomConstraint])
            self.modalBGView.layer?.backgroundColor = CGColor.black
            self.modalBGView.alphaValue = 1.0
            
        }
        
    }
    
}
