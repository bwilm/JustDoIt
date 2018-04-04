//
//  CategoryViewController.swift
//  JustDoIt
//
//  Created by Brandon Wilmott on 3/31/18.
//  Copyright © 2018 Brandon Wilmott. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
  loadCategories()
    }
    
    //MARK -- TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
    
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
    
        return cell
    }

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
   performSegue(withIdentifier: "goToItems", sender: self)
    
    }
    


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
//Add New Categories

  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    

var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message:"", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Category", style: .default){
            
    (action)in
            
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            
          
            
            self.save(category: newCategory)
            
            self.tableView.reloadData()
            
    }
        alert.addAction(action)
        
        
        alert.addTextField {(alertTextField) in
            
                alertTextField.placeholder = "create new Category"
                
            
                textField = alertTextField
                
        }
                
                
                present(alert, animated: true, completion: nil)
    

 
}



    func save(category: Category ){
    
    do {
        try realm.write {
            realm.add(category)
        }
    }catch{
        print("error saving category,\(error)")
    }
    
    tableView.reloadData()

}

func loadCategories(){
    
    categories = realm.objects(Category.self)
    


    tableView.reloadData()
    }

    
    
}


