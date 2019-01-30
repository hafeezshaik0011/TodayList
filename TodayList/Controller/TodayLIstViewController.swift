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
    
      let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       print(dataFilePath)
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
            
            let newItem = ItemClass()
            newItem.title = textField.text!
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
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(todayArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("error in encoding today array \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                todayArray = try decoder.decode([ItemClass].self, from: data)
            }catch{
                print("error in decoding the today array \(error)")
            }
        }
    }

}

