//
//  Category.swift
//  JustDoIt
//
//  Created by Brandon Wilmott on 4/2/18.
//  Copyright © 2018 Brandon Wilmott. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    let array = Array<Int>()
    @objc dynamic var color : String = ""
    
}
