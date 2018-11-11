//
//  AnimalCell.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 11/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class AnimalCell: NSCollectionViewItem {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Returns .xib name for collectionView cell
    ///
    /// - Returns: The XIB name for collectionView cell
    static func getCellIdentifier() -> String
    {
        return "AnimalCell"
    }
    
}
