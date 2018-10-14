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
    var modalView: NSView!
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.closeModalNotif(_:)), name: NOTIF_CLOSE_MODAL, object: nil)
    }
    
    @objc func openProfilePage(_ recogniser: NSClickGestureRecognizer)
    {
        let loginDict: [String : ModalType] = [USER_INFO_MODAL : ModalType.login]
        NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: loginDict)
        
    }
    
    @objc func presentModal(_ notif: Notification)
    {
        var modalWidth = 0
        var modalHeight = 0
        
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
            self.modalBGView.alphaValue = 0.0
            
            let closeBackgroundClick = NSClickGestureRecognizer(target: self, action: #selector(ToolbarVC.closeModalClick(_:)))
            self.modalBGView.addGestureRecognizer(closeBackgroundClick)
            
            //Instantiate xib
            guard let modalType = notif.userInfo?[USER_INFO_MODAL] as? ModalType else {
                return
            }
            switch modalType {
            case ModalType.login:
                self.modalView = ModalLogin()
                modalWidth = 475
                modalHeight = 300
            }
            
            modalView.wantsLayer = true
            modalView.translatesAutoresizingMaskIntoConstraints = false
            modalView.alphaValue = 0.0
            self.view.addSubview(modalView, positioned: .above, relativeTo: self.modalBGView)
            let horizontalConstraint = modalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            let verticalContstraint = modalView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            let widthConstraint = self.modalView.widthAnchor.constraint(equalToConstant: CGFloat(modalWidth))
            let heightConstraint = self.modalView.heightAnchor.constraint(equalToConstant: CGFloat(modalHeight))
            
            NSLayoutConstraint.activate([horizontalConstraint, verticalContstraint, widthConstraint, heightConstraint])
        }
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            self.modalBGView.animator().alphaValue = 0.6
            self.modalView.animator().alphaValue = 1.0
            self.view.layoutSubtreeIfNeeded()
        }, completionHandler: nil)
        
    }
    
    @objc func closeModalClick(_ recogniser: NSGestureRecognizer)
    {
        closeModal()
    }
    
    func closeModal(_ removeImediately: Bool = false)
    {
        if (removeImediately)
        {
            self.modalView.removeFromSuperview()
        }
        else
        {
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = 0.5
                self.modalBGView.animator().alphaValue = 0.0
                self.modalView.animator().alphaValue = 0.0
                self.view.layoutSubtreeIfNeeded()
            }) {
                if (self.modalBGView != nil)
                {
                    self.modalBGView.removeFromSuperview()
                    self.modalBGView = nil
                }
                if (self.modalView != nil)
                {
                    self.modalView.removeFromSuperview()
                    self.modalView = nil
                }
            }
            
        }
    }
    
    @objc func closeModalNotif(_ notification: Notification)
    {
        if let removeImediately = notification.userInfo?[USER_INFO_REMOVE_IMMEDIATELY] as? Bool {
            closeModal(removeImediately)
        }
        else
        {
            closeModal()
        }
    }
    
}
