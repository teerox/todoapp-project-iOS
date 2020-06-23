//
//  HomeViewController.swift
//  ToDo-Application
//
//  Created by macbook on 6/22/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import UIKit
import TinyConstraints
import SimpleCheckbox

class HomeViewController: UIViewController {
    lazy var container = self.createView(with: .clear)
//    lazy var scroller = self.createScrollView()
//    lazy var horizontalScroll = self.createScrollView()
    lazy var logo = self.createImageView(with: #imageLiteral(resourceName: "homeicon2"))
    lazy var viewHeight = container.frame.height
    lazy var viewWidth = container.frame.width
    lazy var tasksText = self.createUIlabelBold(with: "task".localized, and: 40.0, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    lazy var listText = self.createUIlabel(with: "list".localized, and: 40.0, color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    lazy var textContainer = self.createCustomView(with: .clear, height: 70, width: viewWidth/1.68)
    lazy var line = self.createCustomView(with: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), height: 2, width: viewWidth)
    lazy var addTaskButton = self.createButton(with: "", and: .clear, action: nil)
    lazy var addListText =  self.createUIlabel(with: "addlist".localized, and: 16.0, color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
//    lazy var todoContainer = self.createScrollView()
//    lazy var tripContainer = self.createScrollView()
//    lazy var otherContainer = self.createScrollView()
    lazy var checkBox = self.createCheckBox(rect:CGRect(x: 0, y: 0, width: 40, height: 40))


    @IBOutlet weak var homeTabBar: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBarItem.title = ""
        homeTabBar.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        addViews()
        setViewConstraints()
        textContainer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       // scroller.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    }
    
    private func addViews(){
//        view.addSubview(scroller)
//        scroller.edgesToSuperview()
//        scroller.addSubview(self.container)
        self.container.addSubview(logo)
        self.container.addSubview(textContainer)
        self.container.addSubview(line)
        self.container.addSubview(addTaskButton)
        self.container.addSubview(addListText)
       // self.container.addSubview(horizontalScroll)
        addTaskButton.setImage(#imageLiteral(resourceName: "addtaskicon"), for: .normal)
        textContainer.addSubview(tasksText)
        textContainer.addSubview(listText)
        self.container.bringSubviewToFront(textContainer)
//        horizontalScroll.addSubview(todoContainer)
//        horizontalScroll.addSubview(tripContainer)
//        horizontalScroll.addSubview(otherContainer)
       // tripContainer.addSubview(checkBox)
//        
    }
    
    private func setViewConstraints(){
    
        logo.top(to: self.container, offset: viewHeight/12, isActive: true)
        logo.left(to: self.container, offset: viewWidth/9, isActive: true)
        textContainer.topToBottom(of: logo, offset: viewHeight/7, isActive: true)
        line.center(in: textContainer)
        addTaskButton.topToBottom(of: textContainer, offset: 30, isActive: true)
        addTaskButton.centerX(to: self.container)
        textContainer.centerX(to: self.container)
        tasksText.left(to: textContainer, offset: viewWidth/14, isActive: true)
        tasksText.centerY(to: textContainer)
        listText.centerY(to: textContainer)
        listText.right(to: textContainer, offset: -viewWidth/14, isActive: true)
        addListText.topToBottom(of: addTaskButton, offset: 15,  isActive: true)
        addListText.centerX(to: self.container)
//        horizontalScroll.topToBottom(of: addListText, offset: 30,  isActive: true)
//        todoContainer.centerY(to: horizontalScroll)
//        tripContainer.centerY(to: horizontalScroll)
//        otherContainer.centerY(to: horizontalScroll)
//        todoContainer.leftToRight(of: tripContainer, offset: 20, isActive: true)
//        //tripContainer.left(to: horizontalScroll, offset: 20, isActive: true)
//        otherContainer.leftToRight(of: todoContainer, offset: 20, isActive: true)
//        checkBox.centerY(to: tripContainer)
        
        
//        horizontalScroll.height(300)
//        horizontalScroll.width(viewWidth)
//        todoContainer.height(250)
//        todoContainer.width(150)
//        tripContainer.height(250)
//        tripContainer.width(150)
//        otherContainer.height(250)
//        otherContainer.width(150)
       // horizontalScroll.backgroundColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
//        todoContainer.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.7843137255, blue: 0.2509803922, alpha: 1)
//        todoContainer.layer.cornerRadius = 10
//        tripContainer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        tripContainer.layer.cornerRadius = 10
//        otherContainer.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        otherContainer.layer.cornerRadius = 10
        checkBox.uncheckedBorderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        checkBox.borderStyle = .square
        checkBox.checkedBorderColor = .blue
    }
    

}

