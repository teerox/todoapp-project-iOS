//
//  MenuViewController.swift
//  ToDo-Application
//
//  Created by macbook on 6/22/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var menuTabBar: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.layer.contents = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
    
        menuTabBar.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)

    }
    


}
