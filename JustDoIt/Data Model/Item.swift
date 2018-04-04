//
//  Item.swift
//  JustDoIt
//
//  Created by Brandon Wilmott on 4/2/18.
//  Copyright © 2018 Brandon Wilmott. All rights reserved.
//

import Foundation
import RealmSwift


class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
