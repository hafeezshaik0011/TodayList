//
//  CategoryTableViewController.swift
//  TodayList
//
//  Created by apple on 2/1/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryTableViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories : Results<Category>?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
      }
    
     // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "no categories added"
        return cell
    }
    
    
    
    //     marks : - data manipulation methods
    func save(category : Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("error in encoding the category array \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(){
         categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    //    mark:- delete data for swip
    override func updateModel(at indexPath: IndexPath) {
        
        super.updateModel(at: indexPath)
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            }catch{
                print("error in deleting the category \(error)")
            }
        }
        
    }
    //    mark:- add new categories


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "ADD NEW Category HERE", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD ", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder =  "create new category here "
            
        }
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    //     marks:- TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { 
        let destinationVC = segue.destination as! TodayListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
}

