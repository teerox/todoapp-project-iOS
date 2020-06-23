//
//  ViewController.swift
//  ToDo-Application
//
//  Created by macbook on 6/21/20.
//  Copyright © 2020 Decagon. All rights reserved.
//

import UIKit
import RealmSwift
import iOSDropDown


class ViewController: UIViewController {
    
    let realm = try! Realm()
    var allTodo: Results<Todo>?
    
    var allTodoItems:List<TodoItem>?
    // var emptyTodoItems = List<TodoItem>()
    
    @IBOutlet weak var homeView: UIImageView!
    var color = ["Blue","Red","Green","Purple","Cyan"]
    
    @IBOutlet weak var uiUiewCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addBackground()
        uiUiewCollection.backgroundColor = .clear
        loadtodo()
        //uiUiewCollection.delegate = self
        //uiUiewCollection.dataSource = self
        
    }
        override func viewWillAppear(_ animated: Bool) {
          navigationController?.setNavigationBarHidden(true, animated: animated)
            uiUiewCollection.reloadData()
         }
 

  
    
    @IBAction func addTodoItem(_ sender: Any) {
        
        alertDialogue()
    }
    
    
    func addData(title:String,color:String)  {
        let newTodo = Todo()
        newTodo.title = title
        newTodo.color = color
        self.save(allTodo: newTodo)
    }
    
    
    func save(allTodo:Todo) {
        do {
            try realm.write{
                realm.add(allTodo)
            }
        } catch  {
            print("Error \(error)")
        }
        uiUiewCollection.reloadData()
        
    }
    
    func loadtodo() {
        allTodo = realm.objects(Todo.self)
        uiUiewCollection.reloadData()
        // print(allTodo)
    }
    
    //    func loadtodoItem() {
    //         allTodoItems = realm.objects(TodoItem.self)
    //        uiUiewCollection.reloadData()
    //        // print(allTodo)
    //     }
    
    
    func alertDialogue(){
        let alert = UIAlertController(title: "TodoItem",
                                      message: "Add todo",
                                      preferredStyle: .alert)
      
        
       
       
    
        let submitAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            var texts = ""
            let colorItem = self.color[self.generateRandomNum()]
            let textField = alert.textFields![0]
            
            print(colorItem)
            if(textField.text! == ""){
                //text = "No task"
                alert.removeFromParent()
            }else{
                texts = textField.text!
                self.addData(title: texts,color: colorItem)
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
    
    
    func generateRandomNum() -> Int {
        let randomInt = Int.random(in: 0...5)
    return randomInt
    }
    
}




//MARK: - Collection View Delegates

extension ViewController:UICollectionViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = sender as! Todo
        if segue.identifier == "todoselected"{
            let destinationVC = segue.destination as! SingleTodoViewController
            destinationVC.selected = item
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = allTodo?[indexPath.item]
        performSegue(withIdentifier: "todoselected", sender: item)
        
    }
    
}



//MARK: - Collection View DataSource

extension ViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let todoItem = allTodo?[indexPath.row]
        allTodoItems = todoItem?.todo ?? List<TodoItem>()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as! Card
        
        cell.contentView.layer.cornerRadius = 10.0
       
        
        cell.singleTodotitle.text = todoItem?.title ?? "No Category"
        
        cell.singleTodoTableView.reloadData()
 
        if(todoItem?.color == "Red"){
            cell.singleTodoTableView.backgroundColor = UIColor.red
            
            cell.contentView.backgroundColor = UIColor.red
        }else if(todoItem?.color  == "Blue"){
            cell.singleTodoTableView.backgroundColor = UIColor.blue
            cell.contentView.backgroundColor = UIColor.blue
            
        }
        else if(todoItem?.color  == "Cyan"){
            cell.singleTodoTableView.backgroundColor = UIColor.cyan
            cell.contentView.backgroundColor = UIColor.cyan
        }else if(todoItem?.color  == "Purple"){
            cell.singleTodoTableView.backgroundColor = UIColor.purple
            cell.contentView.backgroundColor = UIColor.purple
        }else if(todoItem?.color == "Green"){
            cell.singleTodoTableView.backgroundColor = UIColor.green
            cell.contentView.backgroundColor = UIColor.green
        }else{
            cell.singleTodoTableView.backgroundColor = UIColor.blue
            cell.contentView.backgroundColor = UIColor.blue
        }
        
        
        return cell
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewCell = cell as? Card else { return }
        
        viewCell.settableViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allTodo?.count ?? 1
        
    }
    
    
}




//MARK: - Table View
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allTodo?[tableView.tag].todo.count ?? 1
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =   tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        
        if  let todoItem = allTodo?[tableView.tag].todo[indexPath.row]{
            
            
            if(allTodo?[tableView.tag].color == "Red"){
                cell.backgroundColor = UIColor.red
                cell.contentView.backgroundColor = UIColor.red
            }else if(allTodo?[tableView.tag].color  == "Blue"){
                cell.backgroundColor = UIColor.blue
                cell.contentView.backgroundColor = UIColor.blue
            }
            else if(allTodo?[tableView.tag].color == "Cyan"){
                cell.backgroundColor  = UIColor.cyan
                cell.contentView.backgroundColor = UIColor.cyan
                
            }else if(allTodo?[tableView.tag].color  == "Yellow"){
                cell.backgroundColor  = UIColor.yellow
                cell.contentView.backgroundColor = UIColor.yellow
                
            }else if(allTodo?[tableView.tag].color == "Green"){
                cell.backgroundColor  = UIColor.green
                cell.contentView.backgroundColor = UIColor.green
                
            }else{
                cell.backgroundColor  = UIColor.blue
                cell.contentView.backgroundColor = UIColor.blue
            }
            
           
            
            
            if(todoItem.check){
                //hide the box and cross the text fieled
                let attributedString = NSMutableAttributedString(string: todoItem.todo)
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.white, range: NSMakeRange(0, attributedString.length))
                cell.todoItem.textColor = UIColor.white
//
//                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: todoItem.todo)
//                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                
                cell.todoItem.attributedText = attributedString
                cell.checkBok.isHidden = true
            }else{
                cell.todoItem.text = todoItem.todo
            }
            
            print(todoItem)
            
            cell.checkBok.valueChanged = { (isChecked) in
                print("checkbox is checked: \(isChecked)")
                
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
                
                cell.checkBok.isHidden = true
                
                tableView.reloadData()
            }
            
        }else{
            
            cell.todoItem.text = "No Category"
            //cell.backgroundColor = todoItem? UIColor.brown
        }
        return cell
    }
    
    
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//              let item = allTodo?[indexPath.item]
//              performSegue(withIdentifier: "todoselected", sender: item)
//    }
//    

}


extension UIView {
func addBackground() {
    // screen width and height:
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
    imageViewBackground.image = UIImage(named: "loginbg")

    // you can change the content mode:
    imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill

    self.addSubview(imageViewBackground)
    self.sendSubviewToBack(imageViewBackground)
}}
