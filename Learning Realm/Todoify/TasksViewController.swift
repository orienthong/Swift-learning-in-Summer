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
import RealmSwift

class TasksViewController: UITableViewController {
  
  @IBOutlet weak var filterButton: UIButton!
  
    var tasks: Results<Task>!
    var subscription: NotificationToken?
    
    override func viewDidLoad() {
        tasks = getTasks(false)
        subscription = notificationSubscription(tasks)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func getTasks(done: Bool) -> Results<Task> {
        let realm = try! Realm()
        tasks = realm.objects(Task)
        
        if (done) {
            tasks = tasks.filter("done = true")
        }
//        return tasks.sorted("priority", ascending: false)
        return tasks.sorted([
            SortDescriptor(property: "priority", ascending: false),
            SortDescriptor(property: "created", ascending: false)])
    }
    func notificationSubscription(task: Results<Task>) -> NotificationToken
    {
        return tasks.addNotificationBlock { [weak self] (changes: RealmCollectionChange<Results<Task>>) in
            self?.updateUI(changes)
        }
    }
    
    func updateUI(changes: RealmCollectionChange<Results<Task>>) {
        switch changes {
        case .Initial(_):
            tableView.reloadData()
        case .Update(_, let deletions, let insertions, modifications: _):
            tableView.beginUpdates()
            
            tableView.insertRowsAtIndexPaths(insertions.map{NSIndexPath(forRow: $0, inSection: 0)},withRowAnimation: .Automatic)
            tableView.deleteRowsAtIndexPaths(deletions.map {NSIndexPath(forRow: $0, inSection: 0)},withRowAnimation: .Automatic)
            
            tableView.endUpdates()
            break
        case .Error(let error):
            print(error)
        }
    }
    @IBAction func toggleFilter(sender: UIButton) {
    sender.selected = !sender.selected
    tasks = getTasks(sender.selected)
    subscription = notificationSubscription(tasks)
  }
  
  //MARK: - Table methods
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let task = tasks[indexPath.row]
    
    let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell") as! TaskCell
    cell.configureWithTask(task)
    
    return cell
  }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            try! tasks.realm!.write {
                let task = tasks[indexPath.row]
                self.tasks.realm!.delete(task)
            }
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
  
}