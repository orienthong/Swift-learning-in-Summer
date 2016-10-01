//
//  ScaryBugsTableViewController.swift
//  ScaryBugs
//
//  Created by Brian on 10/26/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ScaryBugsTableViewController: UITableViewController {
  
    var allSections: [[ScaryBug?]?]!
//  var bugSections = [BugSection]()
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = editButtonItem()
    tableView.allowsSelectionDuringEditing = true
    setupBugs()
    tableView.estimatedRowHeight = 60.0
    tableView.rowHeight = UITableViewAutomaticDimension

  }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    private func setupBugs() {
        //1
        let sectionTitlesCount = UILocalizedIndexedCollation.currentCollation().sectionTitles.count
        allSections = [[ScaryBug?]?](count: sectionTitlesCount,repeatedValue: nil)
        print(allSections)
        print(allSections[1]?[0]?.name)
        for index in 0 ..< allSections.count {
            print("Why")
            if let _ = allSections[index] {
                print("is ok")
                
            }
        }
        //2
        let bugs = ScaryBug.bugs()
        for bug in bugs{
            let collation = UILocalizedIndexedCollation.currentCollation()
            let sectionNumber = collation.sectionForObject(bug, collationStringSelector: Selector("name"))
            print(sectionNumber)
            if allSections[sectionNumber] == nil {
                print("abc\(allSections[sectionNumber])")
                allSections[sectionNumber] = [ScaryBug?]()
            }
            allSections[sectionNumber]!.append(bug)
        }
        //3
        for index in 0 ... sectionTitlesCount - 1{
            let bugs = allSections[index]
            if let bugs = bugs {
                allSections[index] = bugs.sort(<)
            }
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return allSections.count
        
    }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    var rows = 0
    if let bugSection = allSections[section] {
        rows = bugSection.count
    }
    return rows
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell
    
    let bugSection = allSections[indexPath.section]!
    
    
        cell = tableView.dequeueReusableCellWithIdentifier("BugCell", forIndexPath: indexPath)
        if let bugcell = cell as? ScaryBugCell{
            let bug = bugSection[indexPath.row]!
//            print("\(bug.name)")
            if let bugImage = bug.image {
                bugcell.bugImageView.image = bugImage
            } else {
                bugcell.bugImageView.image = nil
            }
            bugcell.bugNameLabel.text = bug.name
            if bug.howScary.rawValue > ScaryFactor.AverageScary.rawValue {
                bugcell.howScaryImageView.image = UIImage(named: "shockedface2_full")
            }else {
                bugcell.howScaryImageView.image = UIImage(named: "shockedface2_empty")
            }
        
    }
    return cell
  }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return UILocalizedIndexedCollation.currentCollation().sectionIndexTitles[section]
    }
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        let currentCollation = UILocalizedIndexedCollation.currentCollation() as UILocalizedIndexedCollation
        return currentCollation.sectionIndexTitles
    }
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        let currentCollation = UILocalizedIndexedCollation.currentCollation() as UILocalizedIndexedCollation
        return currentCollation.sectionForSectionIndexTitleAtIndex(index)
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            var section = allSections[indexPath.section]!
            section.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            tableView.setEditing(true, animated: true)
        } else {
            tableView.setEditing(false, animated: true)
        }
    }
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let section = allSections[indexPath.section]!
        if section.count > indexPath.row && editing {
            return nil
        }
        return indexPath
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let section = allSections[indexPath.section]!
        if section.count <= indexPath.row && editing {
            self.tableView(tableView, commitEditingStyle: .Insert, forRowAtIndexPath: indexPath)
        }
    }
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let bugSection = allSections[indexPath.section]!
        if bugSection.count <= indexPath.row && editing {
            return false
        } else {
            return true
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    //MARK: -sugue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToEdit" {
            print("fsd")
            let controller = segue.destinationViewController as? EditingTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let bugSection = allSections[indexPath.section]!
            controller?.bug = bugSection[indexPath.row]
        }
    }
    
}