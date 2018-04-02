//
//  ViewController.swift
//  JustDoIt
//
//  Created by Brandon Wilmott on 3/13/18.
//  Copyright © 2018 Brandon Wilmott. All rights reserved.
//

import UIKit
import CoreData


class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        


        
  
        
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
        
       
//       context.delete(itemArray[indexPath.row])
//       itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       
        saveItems()
        
      
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new toDo", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item",style: .default) {
            (action) in
            
        
            
          
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            
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
    
   
    do{
       try context.save()
        
        
    }catch{
        print("error saving data, \(error)")
    }
    
    tableView.reloadData()
    
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){

        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            
        }else{
            request.predicate = categoryPredicate
        }

        do {
            
        itemArray = try context.fetch(request)
       
        }catch{
            print("there was an error, \(error)")
        }
        
        tableView.reloadData()
    
    
    }
}
    //MARK: - Search Bar Method
    
    extension TodoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        print (searchBar.text!)
        
        
        let predicate = NSPredicate(format:"title CONTAINS[cd] %@", searchBar.text!)
        
       
        request.sortDescriptors = [NSSortDescriptor(key: "title",ascending: true)]
        
       
        self.loadItems(with: request, predicate: predicate)

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
        



