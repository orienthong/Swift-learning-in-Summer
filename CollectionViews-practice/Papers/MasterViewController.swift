//
//  MasterViewController.swift
//  Papers
//
/*
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/


import UIKit


class MasterViewController: UICollectionViewController {
  
    @IBOutlet weak var addButton : UIBarButtonItem!
  private var papersDataSource = PapersDataSource()
  private let reuseIdentifier = "PaperCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = editButtonItem()
    navigationController?.setToolbarHidden(true, animated: false)
    let width = CGRectGetWidth(collectionView!.frame) / 3
    let layout = collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: width, height: width)
    
  }
  
  

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "MasterToDetail" {
      let detailViewController = segue.destinationViewController as! DetailViewController
      detailViewController.paper = sender as? Paper
    }
  }

  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
  // MARK: UICollectionViewDataSource
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    
    return papersDataSource.numberOfSections
  }
  
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    return papersDataSource.numberOfPapersInSection(section)
  }
  
  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    
    let sectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! SectionHeaderView
    
    if let title = papersDataSource.titleForSectionAtIndexPath(indexPath) {
      sectionHeaderView.title = title
      sectionHeaderView.icon = UIImage(named: title)
    }
    
    return sectionHeaderView
    
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    // let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PaperCell", forIndexPath: indexPath) as! PaperCell
    // Configure the cell
    
    if let paper = papersDataSource.paperForItemAtIndexPath(indexPath) {
      cell.paper = paper
      cell.editing = editing
    }
        
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
  override func collectionView(collectionView: UICollectionView,
    didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if !editing {
        if let paper = papersDataSource
            .paperForItemAtIndexPath(indexPath) {
            performSegueWithIdentifier("MasterToDetail", sender: paper)
        }
    } else {
        navigationController!.setToolbarHidden(false , animated: true)
    }
  }
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if editing{
            if let indexPaths = collectionView.indexPathsForSelectedItems() {
                if indexPaths.count == 0 {
                    navigationController?.setToolbarHidden(true, animated: true)
                } else {
                    return
                }
            }
        }
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        let indexPath = papersDataSource.indexPathForNewRandomPaper()
        
        let layout = collectionViewLayout as! PapersFlowLayout
        layout.appearingIndexPath = indexPath
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
            self.collectionView?.insertItemsAtIndexPaths([indexPath])
            }, completion: {
                (finished: Bool) -> Void in
                layout.appearingIndexPath = nil
        })
    }
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: editing)
        
        addButton.enabled = !editing
        collectionView?.allowsMultipleSelection = editing
        let indexPaths = collectionView!.indexPathsForVisibleItems()
        
        for indexPath in indexPaths {
            collectionView?.deselectItemAtIndexPath(indexPath, animated: false)
            let cell = collectionView!.cellForItemAtIndexPath(indexPath) as! PaperCell
            cell.editing = editing
        }
        
        if !editing {
            navigationController?.setToolbarHidden(true, animated: animated)
        }
        
    }
    @IBAction func deleteButtonTapped(sender: UIBarButtonItem) {
        let indexPaths = collectionView!.indexPathsForSelectedItems()! as [NSIndexPath]
        let layout = collectionViewLayout as! PapersFlowLayout
        layout.disappearingIndexPaths = indexPaths
        papersDataSource.deleteItemsAtIndexPaths(indexPaths)
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
            self.collectionView!.deleteItemsAtIndexPaths(indexPaths)
            }, completion: {
                (_: Bool) -> Void in
                layout.disappearingIndexPaths = nil
        })
    }
  
}
