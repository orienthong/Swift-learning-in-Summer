//
//  ViewController.swift
//  TacoPOP
//
//  Created by 洪浩东 on 8/16/16.
//  Copyright © 2016 scauos.com. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // once loaded
    var datasource: DataService = DataService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource.delegate = self
        datasource.loadDeliciousTacoData()
        datasource.tacoArray.shuffle()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        headerView.addDropShadow()
        /*
        let nib = UINib(nibName: "TacoCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "TacoCell")
 */
        collectionView.register(TacoCell.self)
    }
}
extension MainVC: DataServiceDelegate {
    func deliciousTacoDataLoaded() {
        print("loaded")
    }
}
extension MainVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.tacoArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TacoCell", for: indexPath) as? TacoCell {
//            cell.configureCell(taco: datasource.tacoArray[indexPath.row])
//            return cell
//        }
        let cell = collectionView.dequeueReusablCell(forIndexPath: indexPath) as TacoCell
        cell.configureCell(taco: datasource.tacoArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TacoCell {
            cell.shake()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

