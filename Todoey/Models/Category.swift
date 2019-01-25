//
//  Category.swift
//  Todoey
//
//  Created by Edgar Barajas on 1/22/19.
//  Copyright © 2019 Edgar Barajas. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
