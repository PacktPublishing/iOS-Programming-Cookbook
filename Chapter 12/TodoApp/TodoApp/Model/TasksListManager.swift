//
//  TasksListManager.swift
//  TodoApp
//
//  Created by Hossam Ghareeb on 12/17/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import CoreData

extension TaskList{
    
    public class func newEntityWithName(name: String, context: NSManagedObjectContext) -> TaskList{
        let list = NSEntityDescription.insertNewObject(forEntityName: "TaskList", into: context) as! TaskList
        list.name = name
        return list
    }
}

class TasksListManager: AbstractManager {
    
    func saveContextForUpdates(){
        do{
            try self.managedObjectContext.save()
        }
        catch{
            print(error)
        }
    }
    
    func deleteList(list: TaskList){

        self.managedObjectContext.delete(list)
        do{
            try self.managedObjectContext.save()
        }
        catch{
            print(error)
        }
    }

    func addNewList(name s: String){
        
        let list = TaskList.newEntityWithName(name: s, context: self.managedObjectContext)
        list.createdAt = NSDate()
        
        do{
            try self.managedObjectContext.save()
        }
        catch{
            print(error)
        }
    }
    
    func fetchAllLists() -> [TaskList]{
        return self.fetchLists(predicate: nil)
    }
    
    private func fetchLists(predicate: NSPredicate? = nil) -> [TaskList]{
        let fetchRequest = TaskList.fetchRequest() as NSFetchRequest
        fetchRequest.predicate = predicate
        do{
            let lists = try self.managedObjectContext.fetch(fetchRequest)
            return lists
        }catch{
            print(error)
        }
        return []
    }
}
