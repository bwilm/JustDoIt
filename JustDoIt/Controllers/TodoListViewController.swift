//
//  ViewController.swift
//  JustDoIt
//
//  Created by Brandon Wilmott on 3/13/18.
//  Copyright © 2018 Brandon Wilmott. All rights reserved.
//

import UIKit
import RealmSwift


class TodoListViewController: UITableViewController {
    
    
    var toDoItems: Results<Item>?
    let realm =  try! Realm()
    
    
    var selectedCategory : Category? {
        didSet{
           loadItems()
        }
    }
    let defaults = UserDefaults.standard
  
  
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        


        
  
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
//
//            toDoItems = items
//        }
    }
//MARK - Tableview datasource methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellforrowAtIndexPath Call")
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row]{
            
    
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        }else{
            cell.textLabel?.text = "No Items added"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
//MARK - Tableview delegate Methods
        
        if let item = toDoItems?[indexPath.row]{
            
            do{
            try realm.write {
                item.done = !item.done
            }
            }catch{
                print("error,\(error)")
            }
            
        }
        
        self.tableView.reloadData()
      
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        print("addbuttonpressed")
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new toDo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item",style: .default) {
            (action) in
            
            if let currentCategory = self.selectedCategory{
                do{
                try self.realm.write {
                
                let newItem = Item()
                newItem.title = textField.text!
                newItem.dateCreated = Date()
                currentCategory.items.append(newItem)
                }
                }
                    catch{
                    print("error occured,\(error)")
                }
            }
            
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
    
    

    
    func loadItems(){

        
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)


        tableView.reloadData()


    }
}

    //MARK: - Search Bar Method
    
    extension TodoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()

        }


        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0{

                loadItems()
                DispatchQueue.main.async {
                      searchBar.resignFirstResponder()
                }


            }
        }

}



