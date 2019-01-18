//
//  Item.swift
//  Todoey
//
//  Created by Edgar Barajas on 1/17/19.
//  Copyright © 2019 Edgar Barajas. All rights reserved.
//

import Foundation

class Item {
    var title: String = ""
    var done: Bool = false
    
    init(title: String) {
        self.title = title
    }
}
