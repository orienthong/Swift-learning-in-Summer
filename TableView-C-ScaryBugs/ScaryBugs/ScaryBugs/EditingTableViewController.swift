//
//  EditingTableViewController.swift
//  ScaryBugs
//
//  Created by 洪浩东 on 7/22/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

class EditingTableViewController: UITableViewController {
    
    var bug : ScaryBug?
    
    @IBOutlet weak var bugImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var ratingTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        guard let bug = bug else { return }
        if let bugImage = bug.image {
            bugImageView.image = bugImage
        }
        nameTextField.text = bug.name
        ratingTextField.text = ScaryBug.scaryFactorToString(bug.howScary)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        guard let bug = bug else { return }
        if let image = bugImageView.image {
            bug.image = image
        }
        if let text = nameTextField.text {
            bug.name = text
        }
        //what about the rating?
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let picker = UIImagePickerController()
            picker.sourceType = .PhotoLibrary
            picker.allowsEditing = false
            picker.delegate = self
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
extension EditingTableViewController : UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            bug?.image = image
            bugImageView.image = image
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}
