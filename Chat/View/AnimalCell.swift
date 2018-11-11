//
//  AnimalCell.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 11/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

class AnimalCell: NSCollectionViewItem {
    
    //MARK:- IBOutlets
    @IBOutlet var animalImage: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        setupView()
    }
    
    
    private func setupView()
    {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.view.layer?.cornerRadius = 10
        self.view.layer?.borderWidth = 2
        self.view.layer?.borderColor = NSColor.darkGray.cgColor
    }
    
    func configureCell(index: Int, type: AnimalType)
    {
        if (type == AnimalType.Dark)
        {
            self.animalImage.image = NSImage(named: NSImage.Name(rawValue: "dark\(index)"))
            self.view.layer?.backgroundColor = NSColor.lightGray.cgColor
        }
        else
        {
            self.animalImage.image = NSImage(named: NSImage.Name(rawValue: "light\(index)"))
            self.view.layer?.backgroundColor = NSColor.gray.cgColor
        }
    }
    
    /// Returns .xib name for collectionView cell
    ///
    /// - Returns: The XIB name for collectionView cell
    static func getCellIdentifier() -> String
    {
        return "AnimalCell"
    }
    
}
