//
//  AddItemTableViewControllerDelegate.swift
//  BucketList
//
//  Created by Lisa Ryland on 1/16/18.
//  Copyright © 2018 Lisa Ryland. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingItem item: String, at indexPath: NSIndexPath?)
    func addItemViewController(_ controller: AddItemTableViewController, didPressCancelButton button: UIBarButtonItem) // Taken from CancelButtonDelegate file, and altered to match pattern.
    // NOTE: You will need to update AddItemTableViewController to make the Cancel Button work
}

