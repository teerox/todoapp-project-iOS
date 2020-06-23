//
//  SingleTodoCell.swift
//  ToDo-Application
//
//  Created by macbook on 6/21/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import UIKit
import SimpleCheckbox

class TodoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var checkBok: Checkbox!
    
    @IBOutlet weak var todoItem: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkBok.checkedBorderColor = .black
        checkBok.uncheckedBorderColor = .black
        checkBok.checkmarkColor = .red
    }

    class func getIdentifier() -> String {
         return "todoCell"
     }
}



