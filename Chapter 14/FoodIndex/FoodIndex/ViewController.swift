//
//  ViewController.swift
//  FoodIndex
//
//  Created by Hossam Ghareeb on 1/23/17.
//  Copyright © 2017 Hossam Ghareeb. All rights reserved.
//

import UIKit
import CoreSpotlight

struct Item{
    let title: String
    let calories: Int
    let protein: Int
    let fat: Int
    let carbs: Int
    
    func description() -> String {
        return "Calories \(self.calories) kcal, Protein: \(self.protein) g, Fat: \(self.fat) g, Carbs: \(self.carbs) g"
    }
}

class ViewController: UIViewController {
    
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let path = Bundle.main.path(forResource: "Food", ofType: "plist") {
            
            if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
                for itemDic in array{
                    let itemTitle = itemDic["title"] as! String
                    let calories = (itemDic["calories"] as! NSNumber).intValue
                    let protein = (itemDic["protein"] as! NSNumber).intValue
                    let fat = (itemDic["fat"] as! NSNumber).intValue
                    let carbs = (itemDic["carbs"] as! NSNumber).intValue
                    let item = Item(title: itemTitle,
                                    calories: calories,
                                    protein: protein,
                                    fat: fat,
                                    carbs: carbs)
                    self.items.append(item)
                    
                    createSearchableItemFrom(item)
                }
            }
        }
    }
    
    func createSearchableItemFrom(_ item: Item){
        // Create an attribute set to describe an item.
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: "com.hossamghareeb.foodItem")
        // Add metadata that supplies details about the item.
        attributeSet.title = item.title
        attributeSet.contentDescription = item.description()
        
        // Create an item with a unique identifier, a domain identifier, and the attribute set you created earlier.
        let item = CSSearchableItem(uniqueIdentifier: item.title, domainIdentifier: "com.hossamghareeb.foodItem", attributeSet: attributeSet)
        
        // Add the item to the on-device index.
        CSSearchableIndex.default().indexSearchableItems([item]) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            else {
                print("Item indexed.")
            }
        }
    }

}



extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let item = self.items[indexPath.row]
        cell?.textLabel?.text = item.title
        cell?.detailTextLabel?.text = item.description()
        return cell!
    }
}

