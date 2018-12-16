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
    case CreateAccount
    case Profile
    case AddChannel
}

class ToolbarVC: NSViewController {

    //MARK:- IBOutlets
    @IBOutlet private var userAvatar: NSImageView!
    @IBOutlet private var loginLabel: NSTextField!
    @IBOutlet private var loginStackView: NSStackView!
    
    //MARK:- Variables
    private var modalBGView: ClickBlockingView!
    private var modalView: NSView!
    
    //MARK:- ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setFrameSize(NSSize(width: 950, height: 600))
        setupViews()
        startObservingForNotifications()
    }
    
    override func viewWillAppear() {
        if (UserDataService.sharedInstance.isMinimizing) {
            return
        }
        setupViews()
        if (AuthService.sharedInstance.isLoggedIn)
        {
            AuthService.sharedInstance.findUserByEmail(AuthService.sharedInstance.userEmail) { (user) in
                if let loggedUser = user {
                    UserDataService.initializeUserDataServiceSingletonWith(object: loggedUser)
                }
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
                }
            }
        }
    }
    
    
    private func setupViews()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = toolbarColor.cgColor
        self.loginLabel.setFont(loginFont, textColor: grayTextColor)
        
        self.loginStackView.gestureRecognizers.removeAll()
        let profilePage = NSClickGestureRecognizer(target: self, action: #selector(ToolbarVC.openProfilePage))
        self.loginStackView.addGestureRecognizer(profilePage)
    }
    
    private func startObservingForNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.presentModal(_:)), name: NOTIF_PRESENT_MODAL, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.closeModalNotif(_:)), name: NOTIF_CLOSE_MODAL, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ToolbarVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
        
    }
    
    @objc private func openProfilePage(_ recogniser: NSClickGestureRecognizer)
    {
        if (AuthService.sharedInstance.isLoggedIn)
        {
            let profileDict: [String: ModalType] = [USER_INFO_MODAL: ModalType.Profile]
            NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: profileDict)
        }
        else
        {
            let loginDict: [String : ModalType] = [USER_INFO_MODAL : ModalType.login]
            NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: loginDict)
        }
    }
    
    @objc private func presentModal(_ notif: Notification)
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
            
        }
        
        //Instantiate xib
        guard let modalType = notif.userInfo?[USER_INFO_MODAL] as? ModalType else {
            return
        }
        switch modalType {
        case ModalType.login:
            self.modalView = ModalLogin()
            modalWidth = 475
            modalHeight = 300
        case ModalType.CreateAccount:
            self.modalView = ModalCreateAccount()
            modalWidth = 475
            modalHeight = 300
        case ModalType.Profile:
            modalView = ModalProfile()
            modalWidth = 475
            modalHeight = 300
        case ModalType.AddChannel:
            modalView = ModalAddChannel()
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
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            self.modalBGView.animator().alphaValue = 0.6
            self.modalView.animator().alphaValue = 1.0
            self.view.layoutSubtreeIfNeeded()
        }, completionHandler: nil)
        
    }
    
    @objc private func closeModalClick(_ recogniser: NSGestureRecognizer)
    {
        closeModal()
    }
    
    private func closeModal(_ removeImediately: Bool = false)
    {
        if (removeImediately)
        {
            self.modalView.removeFromSuperview()
            self.modalView = nil
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
    
    @objc private func closeModalNotif(_ notification: Notification)
    {
        if let removeImediately = notification.userInfo?[USER_INFO_REMOVE_IMMEDIATELY] as? Bool {
            closeModal(removeImediately)
        }
        else
        {
            closeModal()
        }
    }
    
    @objc private func userDataDidChange(_ notif: Notification)
    {
        if (AuthService.sharedInstance.isLoggedIn)
        {
            loginLabel.stringValue = UserDataService.sharedInstance.name
            userAvatar.wantsLayer = true
            userAvatar.layer?.cornerRadius = 5
            userAvatar.layer?.borderColor = NSColor.white.cgColor
            userAvatar.layer?.borderWidth = 1
            userAvatar.image = NSImage(named: NSImage.Name(rawValue: UserDataService.sharedInstance.avatarName))
            
            //Check if color is changed from the default
            if UserDataService.sharedInstance.avatarColor != "" {
                let avatarColor = UserDataService.sharedInstance.avatarColor.color()
                userAvatar.layer?.backgroundColor = avatarColor?.cgColor
            }
        }
        else
        {
            loginLabel.stringValue = "Log in"
            userAvatar.wantsLayer = true
            userAvatar.layer?.borderWidth = 0
            userAvatar.image = NSImage(named: NSImage.Name(rawValue: "profileDefault"))
            userAvatar.layer?.backgroundColor = CGColor.clear
        }
    }
    
}
