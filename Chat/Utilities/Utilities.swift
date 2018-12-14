//
//  Utilities.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 25/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class Utilities: NSObject {

    class func updateTableView(_ tableView: NSTableView)
    {
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
    class func showDefaultAlert(_ message: String)
    {
        let button = NSButton(title: "OK", target: self, action: nil)
        let alert = Alert(messageText: message, buttons: [button], icon: nil)
        alert.showAlert()
    }
    
    class func scrollRowToVisible(ForTableView tableView: NSTableView, row rowIndex: Int)
    {
        DispatchQueue.main.async {
            tableView.scrollRowToVisible(rowIndex)
        }
    }
}
