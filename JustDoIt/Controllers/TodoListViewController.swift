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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        print(dataFilePath!)

        
        loadItems()
        
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
       
        saveItems()
        
      
        
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
            
            self.saveItems()
            
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
    
  func  saveItems() {
    
    let encoder = PropertyListEncoder()
    do{
        let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
    }catch{
        print("error encoding data, \(error)")
    }
    
    tableView.reloadData()
    
    }
    
    func loadItems(){
        
        
        let data = try? Data(contentsOf: dataFilePath!)
        let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from:data!)
            }catch{
                print("error,\(error)")
                
            
            
        }
      
        }
        
    
    }



