//
//  SelectionDelegate.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 29/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

protocol SelectionDelegate: class {
    func tableView(_tableView: NSTableView, didSelectObject object: NSObject)
}
