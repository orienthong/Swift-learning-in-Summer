/*
* Copyright (c) 2015 Razeware LLC
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
import MapKit

class LogViewController: UITableViewController {
  
  var specimens = []
  var searchResults = []
  
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  var searchController: UISearchController!
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let searchResultsController = UITableViewController(style: .Plain)
    searchResultsController.tableView.delegate = self
    searchResultsController.tableView.dataSource = self
    searchResultsController.tableView.rowHeight = 63
    searchResultsController.tableView.registerClass(LogCell.self, forCellReuseIdentifier: "LogCell")
    
    searchController = UISearchController(searchResultsController: searchResultsController)
    searchController.searchResultsUpdater = self
    searchController.searchBar.sizeToFit()
    searchController.searchBar.tintColor = UIColor.whiteColor()
    searchController.searchBar.delegate = self
    searchController.searchBar.barTintColor = UIColor(red: 0, green: 104.0/255.0, blue: 55.0/255.0, alpha: 1.0)
    tableView.tableHeaderView?.addSubview(searchController.searchBar)
    
    definesPresentationContext = true
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
    
  //MARK: - Actions & Segues
  
  @IBAction func scopeChanged(sender: AnyObject) {
  }
}

// MARK: - UISearchResultsUpdating
extension LogViewController: UISearchResultsUpdating {
  
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    let searchResultsController = searchController.searchResultsController as! UITableViewController
    searchResultsController.tableView.reloadData()
  }
  
}

// MARK: - UISearchBarDelegate
extension LogViewController:  UISearchBarDelegate {
  
}

// MARK: - UITableViewDataSource
extension LogViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchController.active ? searchResults.count : specimens.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("LogCell") as! LogCell
    
    return cell
  }
  
}

