//
//  Data.swift
//  ToDo-Application
//
//  Created by macbook on 6/22/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name = ""
    @objc dynamic var age:Int = 0
    
}
