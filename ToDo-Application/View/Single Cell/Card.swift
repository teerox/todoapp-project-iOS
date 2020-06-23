//
//  Card.swift
//  ToDo-Application
//
//  Created by macbook on 6/21/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import UIKit
import RealmSwift

class Card: UICollectionViewCell {
    
    
    
    @IBOutlet weak var singleTodotitle: UILabel!
    
    
    @IBOutlet weak var singleTodoTableView: UITableView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
}

extension Card{
    
    func settableViewDataSourceDelegate(dataSourceDelegate: UITableViewDataSource & UITableViewDelegate, forRow row: Int) {
        singleTodoTableView.delegate = dataSourceDelegate
        singleTodoTableView.dataSource = dataSourceDelegate
        singleTodoTableView.tag = row
        singleTodoTableView.reloadData()
        
    }
    
    
    
}

