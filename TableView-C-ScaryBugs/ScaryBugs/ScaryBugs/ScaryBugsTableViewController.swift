//
//  ScaryBugsTableViewController.swift
//  ScaryBugs
//
//  Created by Brian on 10/26/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ScaryBugsTableViewController: UITableViewController {
  
  var bugs = [ScaryBug]()
  var bugSections = [BugSection]()
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = editButtonItem()
    tableView.allowsSelectionDuringEditing = true
    setupBugs()
  }
    /*case NotScary
    case ALittleScary
    case AverageScary
    case QuiteScary
    case Aiiiiieeeee*/
    
    private func setupBugs() {
        bugSections.append(BugSection(howScary: .NotScary))
        bugSections.append(BugSection(howScary: .ALittleScary))
        bugSections.append(BugSection(howScary: .AverageScary))
        bugSections.append(BugSection(howScary: .QuiteScary))
        bugSections.append(BugSection(howScary: .Aiiiiieeeee))
        
        let bugs = ScaryBug.bugs()
        for bug: ScaryBug in bugs {
            let bugSection = bugSections[bug.howScary.rawValue]
            bugSection.bugs.append(bug)
        }
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return bugSections.count
    }
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let adjustEditing = editing ? 1 : 0
    let bugSection = bugSections[section]
    return bugSection.bugs.count + adjustEditing
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("BugCell", forIndexPath: indexPath)
    
    if indexPath.row >= bugSections[indexPath.section].bugs.count && editing{
        
        cell.imageView?.image = nil
        cell.textLabel?.text = "Add bug"
        cell.detailTextLabel?.text = nil
    } else {
    let bugSection = bugSections[indexPath.section]
    let bug = bugSection.bugs[indexPath.row]
    cell.textLabel?.text = bug.name
    cell.detailTextLabel?.text = ScaryBug.scaryFactorToString(bug.howScary)
        guard let imageView = cell.imageView else { return cell }
        if let bugImage = bug.image {
            imageView.image = bugImage
        } else {
            imageView.image = nil
        }
    }
    return cell
  }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ScaryBug.scaryFactorToString(bugSections[section].howScary)
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let section = bugSections[indexPath.section]
            section.bugs.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        if editingStyle == .Insert {
            let bugSection = bugSections[indexPath.section]
            let newBug = ScaryBug(withName: "New Bug", imageName: nil, howScary: bugSection.howScary)
            bugSection.bugs.append(newBug)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        let section = bugSections[indexPath.section]
        if indexPath.row >= section.bugs.count {
            return .Insert
        } else {
            return .Delete
        }
    }
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            tableView.beginUpdates()
            for (index, bugSection) in bugSections.enumerate() {
                let indexPath = NSIndexPath(forRow: bugSection.bugs.count, inSection: index)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            tableView.endUpdates()
            tableView.setEditing(true, animated: true)
        } else {
            tableView.beginUpdates()
            for (index, bugSection) in bugSections.enumerate() {
                let indexPath = NSIndexPath(forRow: bugSection.bugs.count, inSection: index)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            tableView.endUpdates()
            tableView.setEditing(false, animated: true)
        }
    }
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let section = bugSections[indexPath.section]
        if section.bugs.count > indexPath.row && editing {
            return nil
        }
        return indexPath
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let section = bugSections[indexPath.section]
        if section.bugs.count <= indexPath.row && editing {
            self.tableView(tableView, commitEditingStyle: .Insert, forRowAtIndexPath: indexPath)
        }
    }
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let bugSection = bugSections[indexPath.section]
        if bugSection.bugs.count <= indexPath.row && editing {
            return false
        } else {
            return true
        }
    }
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let sourceSection = bugSections[sourceIndexPath.section]
        let bugToMove = sourceSection.bugs[sourceIndexPath.row]
        
        let destinationSection = bugSections[destinationIndexPath.section]
        
        if sourceIndexPath == destinationIndexPath {
            //don't move
            return
        }
        if destinationSection == sourceSection {
            swap(&destinationSection.bugs[destinationIndexPath.row], &sourceSection.bugs[sourceIndexPath.row])
        } else {
            bugToMove.howScary = destinationSection.howScary
            destinationSection.bugs.insert(bugToMove, atIndex: destinationIndexPath.row)
            sourceSection.bugs.removeAtIndex(sourceIndexPath.row)
        }
        //fix the bug when move different section , the row information didn't refresh 
        let delayInSections: Double = 0.2
        let dispatchTime =  Int64(delayInSections * Double(NSEC_PER_SEC))
        let popTime = dispatch_time(DISPATCH_TIME_NOW, dispatchTime)
        dispatch_after(popTime, dispatch_get_main_queue(), {
            () -> Void in
            self.tableView.reloadRowsAtIndexPaths([destinationIndexPath], withRowAnimation: .None)
        })
    }
    //It doesn’t make sense to allow a user to move a row below the Add Bug row
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        let bugSection = bugSections[proposedDestinationIndexPath.section]
        if proposedDestinationIndexPath.row >= bugSection.bugs.count {
            return NSIndexPath(forRow: bugSection.bugs.count - 1, inSection: proposedDestinationIndexPath.section)
        }
        return proposedDestinationIndexPath
    }
}