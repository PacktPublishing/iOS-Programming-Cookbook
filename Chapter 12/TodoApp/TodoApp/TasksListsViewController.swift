//
//  ViewController.swift
//  TodoApp
//
//  Created by Hossam Ghareeb on 12/17/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class TasksListsViewController: UIViewController {

    @IBOutlet weak var tasksListsTableView: UITableView!
    
    var currentCreateAction:UIAlertAction!
    
    var tasksLists: [TaskList] = [TaskList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadTasks()
    }

    func loadTasks(){
        let tasksListsManager = TasksListManager()
        self.tasksLists = tasksListsManager.fetchAllLists()
        self.tasksListsTableView.reloadData()
    }

    @IBAction func didClickOnAddButton(_ sender: Any) {
        
        displayAlertToAddOrUpdateTaskList(toUpdateList: nil)
    }
    
    func displayAlertToAddOrUpdateTaskList(toUpdateList: TaskList?){
        
        var title = "New Tasks List"
        var doneTitle = "Create"
        if toUpdateList != nil {
            title = "Update Tasks List"
            doneTitle = "Update"
        }

        let alertController = UIAlertController(title: title, message: "Write the name of your tasks list.", preferredStyle: .alert)
        let createAction = UIAlertAction(title: doneTitle, style: .default) { (action) -> Void in
            
            let listName = alertController.textFields?.first?.text ?? ""
            let tasksListsManager = TasksListManager()
            if let updatedList = toUpdateList{
                updatedList.name = listName
                tasksListsManager.saveContextForUpdates()
            }
            else{
                tasksListsManager.addNewList(name: listName)
            }
            
            self.loadTasks()
            print(listName)
        }
        
        alertController.addAction(createAction)
        createAction.isEnabled = false
        self.currentCreateAction = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField { (textField) in
            textField.placeholder = "Task List Name"
            
            textField.addTarget(self, action: #selector(TasksListsViewController.listNameFieldDidChange(textField:)), for: .editingChanged)
            
            if let updatedList = toUpdateList{
                textField.text = updatedList.name
            }
        }

        self.present(alertController, animated: true, completion: nil)
    }
    
    //Enable the create action of the alert only if textfield text is not empty
    func listNameFieldDidChange(textField:UITextField){
        self.currentCreateAction.isEnabled = (textField.text ?? "").characters.count > 0
    }

}

extension TasksListsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasksLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let list = self.tasksLists[indexPath.row]
        cell?.textLabel?.text = list.name
        cell?.detailTextLabel?.text = "\(list.tasks?.count ?? 0) Tasks"
        return cell!
    }
}

extension TasksListsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler:
            { (deleteAction, indexPath) in
                let tasksListsManager = TasksListManager()
                let listToBeDeleted = self.tasksLists[indexPath.row]
                tasksListsManager.deleteList(list: listToBeDeleted)
                self.tasksLists.remove(at: indexPath.row)
                self.tasksListsTableView.deleteRows(at: [indexPath], with: .fade)
                
        })
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler:
            { (editAction, indexPath) in
                let listToBeUpdated = self.tasksLists[indexPath.row]
                self.displayAlertToAddOrUpdateTaskList(toUpdateList: listToBeUpdated)
                
        })
        return [deleteAction, editAction]
    }
}
