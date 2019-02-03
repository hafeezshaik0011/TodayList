//
//  AppDelegate.swift
//  TodayList
//
//  Created by apple on 1/25/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do{
           _ = try Realm()
                    }
        catch{
            print("error in initializing new realm \(error )")
        }
        
        return true
    }


    
    
    



}

