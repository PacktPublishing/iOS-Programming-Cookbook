//
//  ViewController.swift
//  Todo
//
//  Created by Hossam Ghareeb on 9/10/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tasksTableView: UITableView!
    var tasks = [Task]()
    var isEditingMode = false
    var currentCreateAction:UIAlertAction?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func didClickOnEditButton(_ sender: AnyObject) {
        isEditingMode = !isEditingMode
        self.tasksTableView.setEditing(isEditingMode, animated: true)
    }

    
    @IBAction func didClickOnAddButton(_ sender: AnyObject) {
        self.displayAlertToAddTask()
    }

    func displayAlertToAddTask(){
        
        let title = "New Task"
        let doneTitle = "Create"
        
        let alertController = UIAlertController(title: title, message: "Write the name of your task.", preferredStyle: .alert)
        let createAction = UIAlertAction(title: doneTitle, style: .default) { (action) -> Void in
            
            let taskName = alertController.textFields?.first?.text
            let newTask = Task(taskName: taskName!)
            
            self.tasks.append(newTask)
            
            self.tasksTableView.insertRows(at: [IndexPath(row: self.tasks.count - 1, section: 0)], with: .top)
        }
        
        alertController.addAction(createAction)
        createAction.isEnabled = false
        self.currentCreateAction = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Task Name"
            textField.addTarget(self, action: #selector(ViewController.taskNameFieldDidChange(textField:)) , for: .editingChanged)
            
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Enable the create action of the alert only if textfield text is not empty
    func taskNameFieldDidChange(textField:UITextField){
        self.currentCreateAction?.isEnabled = (textField.text?.characters.count)! > 0
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            self.tasks.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return [deleteAction]
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell")
        let task = tasks[indexPath.row]
        cell?.textLabel?.text = task.name
        cell?.showsReorderControl = true
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let taskToMove = self.tasks[sourceIndexPath.row]
        self.tasks.remove(at: sourceIndexPath.row)
        self.tasks.insert(taskToMove, at: destinationIndexPath.row)
    }
}
