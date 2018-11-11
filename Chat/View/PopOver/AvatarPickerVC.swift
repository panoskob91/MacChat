//
//  AvatarPickerVC.swift
//  Chat
//
//  Created by Panagiotis  Kompotis  on 11/11/2018.
//  Copyright © 2018 Panagiotis  Kompotis. All rights reserved.
//

import Cocoa

enum AnimalType {
    case Dark
    case Light
}

class AvatarPickerVC: NSViewController,
NSCollectionViewDelegate,
NSCollectionViewDataSource,
NSCollectionViewDelegateFlowLayout
{
    
    //MARK:- IBOutlets
    @IBOutlet private var segmentControl: NSSegmentedControl!
    @IBOutlet private var collectionView: NSCollectionView!
    
    //Constants
    let collectionViewCell = "collectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: AnimalCell.getCellIdentifier()), for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSMakeSize(85.0, 85.0)
    }
}
