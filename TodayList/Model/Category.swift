//
//  Category.swift
//  TodayList
//
//  Created by apple on 2/2/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
