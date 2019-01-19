//
//  ViewController.swift
//  Todoey
//
//  Created by Edgar Barajas on 1/16/19.
//  Copyright © 2019 Edgar Barajas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var defaults = UserDefaults.standard
    var items = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].title
        
        cell.accessoryType = items[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        items[indexPath.row].done = !items[indexPath.row].done
        
        saveItems()
        
        tableView.reloadData()
    }

    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new Todoey item", message: "noob noob noob", preferredStyle: .alert)

        let addItemAction = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what happens when the user hits the Add item button on our UIAlert
            print("Success")
            
            let item = Item(title: textField.text!)
            
            self.items.append(item)
            
            self.saveItems()
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter a Todoey"
            textField = alertTextField
        }
        
        alert.addAction(addItemAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.items)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding data")
        }
    }
    
    func loadItems() {
        if let data = try? Data.init(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error getting data")
            }
            
        }
    }
    
}

