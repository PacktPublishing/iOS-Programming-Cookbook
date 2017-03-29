//
//  ViewController.swift
//  AppSearch
//
//  Created by Hossam Ghareeb on 1/22/17.
//  Copyright © 2017 Hossam Ghareeb. All rights reserved.
//

import UIKit
import CoreSpotlight

struct Item{
    let name: String
    let price: Float
}

class ViewController: UIViewController {
    
    @IBOutlet weak var itemsTableView: UITableView!
    var createAction: UIAlertAction?
    var alertController: UIAlertController?
    var currentActivity: NSUserActivity?
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didClickOnAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "New Item", message: "Enter the name and price of the new item.", preferredStyle: .alert)
        self.alertController = alertController
        alertController.addTextField { (textField) in
            textField.placeholder = "Item Name"
            textField.addTarget(self, action: #selector(ViewController.textFieldDidChange(textField:)), for: .editingChanged)
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Item Price"
            textField.keyboardType = .numberPad
            textField.addTarget(self, action: #selector(ViewController.textFieldDidChange(textField:)), for: .editingChanged)
        }
        let createAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            print("Submit")
            if let fields = alertController.textFields{
                let item = Item(name: fields[0].text!, price: (fields[1].text! as NSString).floatValue)
                self.items.append(item)
                self.itemsTableView.insertRows(at: [IndexPath(row: self.items.count - 1, section: 0)], with: .fade)
                self.createSearchableActivityForItem(item)
            }
            
        }
        createAction.isEnabled = false
        self.createAction = createAction
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func textFieldDidChange(textField: UITextField){
        if let _ = self.alertController, let action = self.createAction, let fields = self.alertController?.textFields{
            var isValid = true
            for textField in fields{
                if let text = textField.text{
                    isValid = isValid && text.characters.count > 0
                }
                
            }
            action.isEnabled = isValid
        }
    }
    
    
    func createSearchableActivityForItem(_ item: Item){

        let activity: NSUserActivity = NSUserActivity(activityType: "com.hossamghareeb.ItemType")
        
        // Set properties that describe the activity and that can be used in search.
        activity.title = "\(item.name)"
        activity.userInfo = ["name": "\(item.name)", "price": "\(item.price)"]
        let attributeSet = CSSearchableItemAttributeSet()
        attributeSet.contentDescription = "Price: $\(item.price) \n Adde on: \(NSDate())"
        attributeSet.title = "\(item.name)"
        activity.contentAttributeSet = attributeSet
        
        // Add the item to the private on-device index.
        activity.isEligibleForSearch = true
        self.currentActivity = activity
        
        activity.becomeCurrent()
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let item = self.items[indexPath.row]
        cell?.textLabel?.text = item.name
        cell?.detailTextLabel?.text = "$\(item.price)"
        return cell!
    }
}

