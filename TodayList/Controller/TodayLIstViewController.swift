//
//  ViewController.swift
//  TodayList
//
//  Created by apple on 1/25/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import CoreData

class TodayListViewController: UITableViewController {
   
    var todayArray = [Item]()
    
    var selectedCategory : Category?{
        didSet{
            loadData()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadData()
 }
    //  MARK:- create the data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "TodayItemCell", for: indexPath)
        
        let item = todayArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
//        ternary Operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        

        
        return cell
    }
    
    //    MARK:- creat the delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todayArray[indexPath.row])
        
         todayArray[indexPath.row].done = !todayArray[indexPath.row].done
       
        saveItems()
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //    MARK :- add  bar button here
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
       let alert = UIAlertController(title: "ADD NEW ITEM HERE", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD ITEM", style: .default) { (UIAlertAction) in
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.todayArray.append(newItem)
            self.saveItems()
    
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    //    mark:-model manupulation methods
    
    func saveItems(){
        
        
        do{
           try context.save()
        }catch{
            print("error in encoding today array \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData(with request : NSFetchRequest<Item> = Item.fetchRequest(),predicate:NSPredicate? = nil ){
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionPredicate])
        }else{
            request.predicate = categoryPredicate 
        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
//        request.predicate = categoryPredicate
        
        do{
         todayArray = try context.fetch(request)
        }catch{
            print("error fetching data from context \(error)")
        }
        tableView.reloadData()

    }

}

extension TodayListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request .predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        request.sortDescriptors = [sortDescriptor]
        
        loadData(with: request,predicate: predicate)

            }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

