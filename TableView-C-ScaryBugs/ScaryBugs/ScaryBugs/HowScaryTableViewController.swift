//
//  HowScaryTableViewController.swift
//  ScaryBugs
//
//  Created by 洪浩东 on 7/22/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class HowScaryTableViewController: UITableViewController {

    var bug: ScaryBug!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    
    
    func refresh() {
        for index in 0 ... ScaryFactor.TotalBugs.rawValue {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = bug.howScary.rawValue == index ? .Checkmark : .None
        }
    }
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let scaryFactor = ScaryFactor(rawValue: indexPath.row) {
            bug.howScary = scaryFactor
        }
        refresh()
    }
}
