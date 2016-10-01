//
//  StickerCollectionViewController.swift
//  Stickerlicious
//
//  Created by 洪浩东 on 8/5/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit
import Messages

private let reuseIdentifier = "StickerCollectionViewCell"

let stickerNameGroups: [String: [String]] = [
        "Crunchy": ["CandyCane","JawBreaker","Lollipop"],
        "Chewy": ["Caramel","GummiBear","SourCandy"],
        "Chocolate": ["ChocolateBar","ChocolateChip","DarkChocolate"]
    ]

struct StickerGroup {
    let name: String
    let members: [MSSticker]
}
class StickerCollectionViewController: UICollectionViewController {
    
    var stickerGroups = [StickerGroup]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadStickers()
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        collectionView?.backgroundColor = #colorLiteral( red: 0.9490196078, green: 0.7568627451, blue: 0.8196078431, alpha: 1)
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return stickerGroups.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return stickerGroups[section].members.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StickerCollectionViewCell
        let sticker = stickerGroups[indexPath.section].members[indexPath.row]
        cell.stickerView.sticker = sticker
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionElementKindSectionHeader else { fatalError() }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        header.label.text = stickerGroups[indexPath.section].name
        return header
    }
}
extension StickerCollectionViewController {
    private func loadStickers(_ chocoholic: Bool = false) {
        stickerGroups = stickerNameGroups.filter({ (name, _) in
            return chocoholic ? name == "Chocolate": true
        }).map {(name, stickerNames) in
            // 4
            let stickers: [MSSticker] = stickerNames.map { name in
            let url = Bundle.main().urlForResource(name,withExtension: "png")!
            return try! MSSticker(contentsOfFileURL: url, localizedDescription: name)
            }
            // 5 
            return StickerGroup(name: name, members: stickers)
        }
        // 6 
        stickerGroups.sort(isOrderedBefore: { $0.name < $1.name })
    }
}
//MARK: -UICollectionViewDelegateFlowLayout
extension StickerCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let edge = min(collectionView.bounds.width / 3, 136)
        return CGSize(width: edge, height: edge)
    }
}
extension StickerCollectionViewController: Chocoholicable {
    func setChocoholic(_ chocoholic: Bool) {
        loadStickers(chocoholic)
        collectionView?.reloadData()
    }
}
