//
//  ViewController.swift
//  JustDoIt
//
//  Created by Brandon Wilmott on 3/13/18.
//  Copyright © 2018 Brandon Wilmott. All rights reserved.
//

import UIKit


class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem  = Item()
        newItem.title = "Find Jim"
        
        itemArray.append(newItem)
        
        let newItem2  = Item()
        newItem2.title = "Find Pam"
        itemArray.append(newItem2)
        
        let newItem3  = Item()
        newItem3.title = "Find Toby"
        itemArray.append(newItem3)
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
//
//            itemArray = items
//        }
    }
//MARK - Tableview datasource methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellforrowAtIndexPath Call")
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
//MARK - Tableview delegate Methods
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       

        
       tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new toDo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item",style: .default) {
            (action) in
            
            
          
            let newItem = Item()
            
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
       
    
    }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new toDo"
            print(alertTextField.text!)
           textField = alertTextField
            
        }
        
    alert.addAction(action)
        
    present(alert, animated: true, completion: nil)
}

}

