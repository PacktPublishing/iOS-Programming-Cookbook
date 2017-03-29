//
//  AbstractManager.swift
//  TodoApp
//
//  Created by Hossam Ghareeb on 12/17/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import CoreData

class AbstractManager: NSObject {

    /// The managedObjectContext for core data.
    lazy var managedObjectContext: NSManagedObjectContext = {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.persistentContainer.viewContext
    }()
    
}
