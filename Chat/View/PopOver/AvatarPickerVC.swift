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
    
    //MARK:- ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let layout: NSCollectionViewFlowLayout = NSCollectionViewFlowLayout()
        layout.sectionInset = NSEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView!.collectionViewLayout = layout
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
//        updateContent()
    }
    
    //MARK:- Delegate functions
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: AnimalCell.getCellIdentifier()), for: indexPath)
        guard let animalCell = cell as? AnimalCell else {
            return NSCollectionViewItem()
        }
        let type = getAnimalTypeFromSegmentedControlSelection(self.segmentControl.selectedSegment)
        animalCell.configureCell(index: indexPath.item, type: type)
        
        return animalCell
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSMakeSize(85.0, 85.0)
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let selectedIndexPath = collectionView.selectionIndexPaths.first else {
            return
        }
        
        let type = getAnimalTypeFromSegmentedControlSelection(self.segmentControl.selectedSegment)
        if (type == AnimalType.Dark)
        {
            UserDataService.sharedInstance.avatarName = "dark\(selectedIndexPath.item)"
        }
        else
        {
            UserDataService.sharedInstance.avatarName = "light\(selectedIndexPath.item)"
        }
        self.view.window?.cancelOperation(nil)
    }
    
    //MARK:- Helper functions
    private func getAnimalTypeFromSegmentedControlSelection(_ selectionIndex: Int) -> AnimalType
    {
        if (selectionIndex == 0)
        {
            return AnimalType.Dark
        }
        
        return AnimalType.Light
    }
    
    /// Reloads and updates collection view content
    private func updateContent()
    {
        self.collectionView.reloadData()
    }
    
    //MARK:- IBActions
    @IBAction func segmentedControlPressed(_ sender: NSSegmentedControl)
    {
        updateContent()
    }
    
    
}
