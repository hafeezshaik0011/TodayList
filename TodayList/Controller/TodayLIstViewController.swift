//
//  ViewController.swift
//  TodayList
//
//  Created by apple on 1/25/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class TodayListViewController: UITableViewController {
   
    var todayArray = [ItemClass]()
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        let newItem = ItemClass()
        newItem.title = "make love"
        todayArray.append(newItem)
        
        let newItem1 = ItemClass()
        newItem1.title = "fell in love"
        todayArray.append(newItem1)
        
        let newItem2 = ItemClass()
        newItem2.title = "populate the love"
        todayArray.append(newItem2)
        
        if let items = defaults.array(forKey: "TodayListArray") as? [ItemClass]{
            todayArray = items
        }
       
        
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
        
        
//       if  todayArray[indexPath.row].done == true{
//            cell.accessoryType = .checkmark
//       }else {
//        cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //    MARK:- creat the delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todayArray[indexPath.row])
        
        if todayArray[indexPath.row].done == false {
            todayArray[indexPath.row].done = true
        }else {
            todayArray[indexPath.row].done = false
        }
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
    
    //    MARK :- add  bar button here
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
       let alert = UIAlertController(title: "ADD NEW ITEM HERE", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ADD ITEM", style: .default) { (UIAlertAction) in
            
            let newItem = ItemClass()
            newItem.title = textField.text!
            self.todayArray.append(newItem
            )
//            self.todayArray.append(textField)
            self.defaults.set(self.todayArray, forKey: "TodayListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}

