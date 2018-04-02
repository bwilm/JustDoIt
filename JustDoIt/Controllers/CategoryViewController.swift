//
//  CategoryViewController.swift
//  JustDoIt
//
//  Created by Brandon Wilmott on 3/31/18.
//  Copyright © 2018 Brandon Wilmott. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    
    var categoryArray = [Category]()
    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as!
    AppDelegate).persistentContainer.viewContext
    let dataFilePath =
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Categories.plist")
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
   loadCategories()
    }
    
    //MARK -- TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
    
        cell.textLabel?.text = categoryArray[indexPath.row].name
    
        return cell
    }

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
   performSegue(withIdentifier: "goToItems", sender: self)
    
    }
    


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
//Add New Categories

  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    

var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message:"", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Category", style: .default){
            
    (action)in
            
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
            self.tableView.reloadData()
            
    }
        alert.addAction(action)
        
        
        alert.addTextField {(alertTextField) in
            
                alertTextField.placeholder = "create new Category"
                
            
                textField = alertTextField
                
        }
                
                
                present(alert, animated: true, completion: nil)
    

 
}



func saveCategory(){
    
    do {
        try context.save()
    }catch{
        print("error saving category,\(error)")
    }
    
    tableView.reloadData()

}

func loadCategories(){
    
    let request : NSFetchRequest<Category> = Category.fetchRequest()
    
    do{
    
        categoryArray = try context.fetch(request)
    }catch{
        print("there was an error fetching categories,\(error)")
    }
    
    tableView.reloadData()
    }
    
    
    
}

