//
//  NSView.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 19/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

extension NSView {
    
    func refreshModal(_ modalType: ModalType) {
        self.removeFromSuperview()
        let userInfo: [String: ModalType] = [USER_INFO_MODAL: modalType]
        NotificationCenter.default.post(name: NOTIF_PRESENT_MODAL, object: nil, userInfo: userInfo)
    }
}
