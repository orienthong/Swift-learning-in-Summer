//
//  RatingTableViewController.swift
//  PrettyIcons
//
//  Created by 洪浩东 on 7/23/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class RatingTableViewController: UITableViewController {
    
    var icon : Icon?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func refresh() {
        for index in 0 ... RatingType.Nothing.rawValue {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = icon?.rating.rawValue == index ? .Checkmark : .None
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let rating = RatingType(rawValue: indexPath.row) {
            print("fsd")
            icon?.rating = rating
        }
        refresh()
    }
    
}
