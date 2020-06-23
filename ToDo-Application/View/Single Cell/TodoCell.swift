//
//  TodoCell.swift
//  ToDo-Application
//
//  Created by macbook on 6/21/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import UIKit
import SimpleCheckbox

class TodoCell: UITableViewCell {
    
    
    @IBOutlet weak var checkBok: Checkbox!
    
    @IBOutlet weak var todoItem: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
