//
//  Todo.swift
//  ToDo-Application
//
//  Created by macbook on 6/22/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import RealmSwift

class Todo:Object {
    @objc dynamic var title:String = ""
    @objc dynamic var color:String = "blue"
    let todo = List<TodoItem>()
}


class TodoItem:Object {
    @objc dynamic var check:Bool = false
    @objc dynamic var  todo:String = ""
    @objc dynamic var  date:String = ""
    var parentCategory = LinkingObjects(fromType: Todo.self, property: "todo")
}
