//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Edgar Barajas on 1/21/19.
//  Copyright © 2019 Edgar Barajas. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    func loadCategories(request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching categories")
        }
    }
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add a category", message: "Add what you want", preferredStyle: .alert)
        var textField = UITextField()
        
        let addCategoryAction = UIAlertAction(title: "Add", style: .default) { (action) in
            // save a category
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addAction(addCategoryAction)
        
        alert.addTextField { (actionTextField) in
            actionTextField.placeholder = "Edgar's To-do's"
            textField = actionTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedCategory = categories[indexPath.row]
        }
    }
}
