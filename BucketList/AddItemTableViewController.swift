//
//  AddItemTableViewControllerDelegate.swift
//  BucketList
//
//  Created by Lisa Ryland on 1/16/18.
//  Copyright © 2018 Lisa Ryland. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemTableViewControllerDelegate?
    var item: String?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var itemTextField: UITextField!
    
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.addItemViewController(self, didPressCancelButton: sender)
    }
    
    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        delegate?.addItemViewController(self, didFinishAddingItem: text, at: indexPath)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTextField.text = item

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
