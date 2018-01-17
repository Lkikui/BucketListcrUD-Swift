//
//  BucketListViewController.swift
//  BucketList
//
//  Created by Lisa Ryland on 1/16/18.
//  Copyright © 2018 Lisa Ryland. All rights reserved.
//

import UIKit

var items = ["Sky diving", "Live in Hawaii"]

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    // Add new item
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingItem item: String, at indexPath: NSIndexPath?) {
        print("in BucketListViewController > didFinishAddingItem")
        // Target cell selected
        if let ip = indexPath {
            items[ip.row] = item
        } else {
            items.append(item)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    // If cancel button was pressed
    func addItemViewController(_ controller: AddItemTableViewController, didPressCancelButton button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // Add new mission or edit preexiting one
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Add new
        if segue.identifier == "AddNewMission" {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
        }
        
        // Edit list item
        else if segue.identifier == "EditItemSegue" {
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            addItemTableViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableViewController.item = item
            addItemTableViewController.indexPath = indexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.textLabel?.text = items[indexPath.row]
        // return cell so that Table View knows what to draw in each row
        return cell
    }

}


