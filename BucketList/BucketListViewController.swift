//
//  BucketListViewController.swift
//  BucketList
//
//  Created by Lisa Ryland on 1/16/18.
//  Copyright © 2018 Lisa Ryland. All rights reserved.
//

// Imports
import UIKit
import CoreData

// Class start
class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    // Variables
    var items = [BucketListItem]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // table data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell.textLabel?.text = items[indexPath.row].text!
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    // edit item when icon is tapped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "MissionSegue", sender: indexPath)
    }
    
    // remove item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    // segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // refactored version
        let navigationController = segue.destination as! UINavigationController
        let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
        
        // Set self as Destination Delegate
        addItemTableViewController.delegate = self
        
        // Set item/IndexPath using sender
        if let indexPath = sender as? NSIndexPath {
            let item = items[indexPath.row]
            addItemTableViewController.item = item.text!
            addItemTableViewController.indexPath = indexPath
        }
    }
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
    }
    
    // If cancel button was pressed
    func addItemViewController(_ controller: AddItemTableViewController, didPressCancelButton button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // Add new item
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingItem text: String, at indexPath: NSIndexPath?) {
        print("in BucketListViewController > didFinishAddingItem")
        // Target cell selected
        if let ip = indexPath {
            let item = items[ip.row]
            item.text = text
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }


    
 /* -------------------------
 
 crUD version with two segues
 
 ---------------------------*/
//        // Add new
//        if segue.identifier == "AddNewMission" {
//            let navigationController = segue.destination as! UINavigationController
//            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
//            addItemTableViewController.delegate = self
//        }
//
//        // Edit list item
//        else if segue.identifier == "EditItemSegue" {
//
//            let navigationController = segue.destination as! UINavigationController
//            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
//            addItemTableViewController.delegate = self
//
//            let indexPath = sender as! NSIndexPath
//            let item = items[indexPath.row]
//            addItemTableViewController.item = item
//            addItemTableViewController.indexPath = indexPath
//        }
  
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    

}


