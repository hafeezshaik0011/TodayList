//
//  ViewController.swift
//  TodayList
//
//  Created by apple on 1/25/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class TodayListViewController: UITableViewController {
   
    let todayArray = ["find love","fell in  love","make love"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //  MARK:- create the data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "TodayItemCell", for: indexPath)
        cell.textLabel?.text = todayArray[indexPath.row]
        
        return cell
    }
    
    //    MARK:- creat the delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todayArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

