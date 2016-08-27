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

class TaskCell: UITableViewCell {
    
    var taskId: String?
    
    func configureWithTask(task: Task) {
        taskId = task.taskId
        check.selected = task.done
        title!.text = task.title
        priority!.text = task.priorityText
        priority.textColor = task.priorityColor
        spinner.hidden = true
    }
  
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var priority: UILabel!
  @IBOutlet weak var check: UIButton!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  override func awakeFromNib() {
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight))
    swipeRight.direction = .Right
    contentView.addGestureRecognizer(swipeRight)
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
    contentView.addGestureRecognizer(longPress)
  }
  
  @IBAction func toggleImageChecked(sender: UIButton) {
        updateTask(!check.selected)
  }
    private func updateTask(checked: Bool) {
        if let realm = try? Realm(),
            let id = self.taskId,
            let task = realm.objectForPrimaryKey(Task.self, key: id) {
            try! realm.write {
                task.done = checked
            }
            
            check.selected = task.done
        }
    }

    func didSwipeRight(swipe: UISwipeGestureRecognizer) {
        if let realm = try? Realm(),
        let id = self.taskId,
            let task = realm.objectForPrimaryKey(Task.self, key: id) {
            try! realm.write {
                task.priority = task.priority == 0 ? 1 : 0
            }
        }
    }
    func didLongPress(press: UILongPressGestureRecognizer) {
        if press.state == .Began {
            spinner.hidden = false
            spinner.startAnimating()
            
            delay(2.0, completion: {
                [unowned self] in
                self.spinner.hidden = true
                self.updateTask(true)
            })
        }
    }
}