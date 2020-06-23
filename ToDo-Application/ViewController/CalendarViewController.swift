//
//  CalendarViewController.swift
//  ToDo-Application
//
//  Created by macbook on 6/22/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarTabBar: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.layer.contents = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        calendarTabBar.image = #imageLiteral(resourceName: "calendaricon")
        calendarTabBar.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
    }
}
    

