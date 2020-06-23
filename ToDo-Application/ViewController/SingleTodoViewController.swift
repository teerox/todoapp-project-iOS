//
//  SingleTodoVieControl.swift
//  ToDo-Application
//
//  Created by macbook on 6/22/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import Foundation
import UIKit
import Floaty
import RealmSwift

class SingleTodoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var todoTitle: UILabel!
    
    @IBOutlet weak var addTodoItem: Floaty!
    
    @IBOutlet weak var taskUpdate: UILabel!
    
    
    let realm = try! Realm()
    
    var todoList:Results<TodoItem>?
    
    var selected: Todo? {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(selected!)
         self.view.addBackground()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        todoTitle.text = selected?.title
        floating()
        loadData()
        
    }
    
    
    
    @IBAction func todoDelete(_ sender: Any) {
        
        //pass id to the main controller for deletion
        delete(todo: selected!)
        navigationController?.popViewController(animated: true)
        
    }
    


    @IBAction func gobackHome(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func alertDialogue(){
        let alert = UIAlertController(title: "TodoItem",
                                      message: "Add todo Item",
                                      preferredStyle: .alert)
        
        // Submit button
        let submitAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            var texts = ""
            let textField = alert.textFields![0]
            if(textField.text! == ""){
                //text = "No task"
                alert.removeFromParent()
            }else{
                texts = textField.text!
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                let someDateTime = formatter.string(from: Date())
                
                if let currentTodo = self.selected{
                    do {
                        try self.realm.write{
                            let newtask = TodoItem()
                            newtask.date  = someDateTime
                            newtask.todo = texts
                            currentTodo.todo.append(newtask)
                            
                        }
                    } catch  {
                        print("Error \(error)")
                    }
                    self.tableView.reloadData()
                }
                
            }
        })
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        // Add 1 textField and customize it
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Add Todo item"
            textField.clearButtonMode = .whileEditing
        }
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    //
    func floating(){
        
        addTodoItem.addItem("Add ToDo", icon: UIImage(named: "plus")!, handler: { item in
            self.alertDialogue()
            self.addTodoItem.close()
        })
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.addTodoItem.frame.origin.y == 0 {
                self.addTodoItem.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            self.addTodoItem.frame.origin.y += keyboardSize.height
        }
    }
    
    
    
    func loadData() {
        todoList = selected?.todo.sorted(byKeyPath: "todo", ascending: true)
    }
    
    
    
    //delete method
    func delete(todo:Todo)  {
        do {
            try self.realm.write{
                realm.delete(todo)
            }
        } catch  {
            print("Error \(error)")
        }
    }
}




extension SingleTodoViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped")
        
        
    }
    
    
}

extension SingleTodoViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList?.count ?? 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.getIdentifier(), for: indexPath) as! TodoTableViewCell
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = .clear
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 149))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.0, 0.0, 0.0, 0.0])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
        
        let num = todoList?.count
        var counts = 0

        if let items = todoList{
            for item in items {
                if (item.check){
                    counts += 1
                }
                taskUpdate.text = "completed \(counts) of \(num!) tasks"
              
            }
        }
        
        if let todoItem = todoList?[indexPath.row]{
            cell.checkBok.isChecked = todoItem.check
            cell.todoItem.text = todoItem.todo
            cell.date.text = todoItem.date
            
            
            if(todoItem.check){
                //hide the box and cross the text fieled
                let attributedString = NSMutableAttributedString(string: todoItem.todo)
              attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
              attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.red, range: NSMakeRange(0, attributedString.length))
                cell.todoItem.textColor = UIColor.red
                cell.todoItem.attributedText = attributedString
                
                cell.checkBok.isHidden = true
                
            }
    
            
            
            cell.checkBok.valueChanged = { (isChecked) in
                print("checkbox is checked 2: \(isChecked)")
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: todoItem.todo)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                cell.todoItem.attributedText = attributeString
                
                do {
                    try self.realm.write{
                        todoItem.check = !todoItem.check
                    }
                } catch  {
                    print("Error \(error)")
                }
                
                
                tableView.reloadData()
                //  tableView.deselectRow(at: indexPath, animated: true)
                
                
            }
            
            
            
        }else{
            cell.todoItem.text = "No Item Added"
            cell.date.text = ""
        }
        
        
        
        
        
        
        
        return cell
    }
    
    
    
}

