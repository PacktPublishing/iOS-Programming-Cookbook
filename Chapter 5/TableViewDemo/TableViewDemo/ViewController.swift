//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Hossam Ghareeb on 9/9/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Sweets"
        case 1:
            return "Lebanese Food"
        case 2:
            return "Sea Food"
            
        default:
            return ""
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FoodTableViewCell
        switch indexPath.section {
        case 0: // Sweets
            switch indexPath.row {
            case 0:
                cell.foodNameLabel.text = "Cheese Cake"
                cell.foodImageView?.image = UIImage(named: "CheeseCake")
            case 1:
                cell.foodNameLabel.text = "Donuts"
                cell.foodImageView?.image = UIImage(named: "Donuts")
            case 2:
                cell.foodNameLabel.text = "Arabic Sweets"
                cell.foodImageView?.image = UIImage(named: "ArSweets")
            default:
                print("No more cells in this section")
            }
        case 1: // Lebanese food
            switch indexPath.row {
            case 0:
                cell.foodNameLabel.text = "Shawerma"
                cell.foodImageView?.image = UIImage(named: "Shawerma")
            case 1:
                cell.foodNameLabel.text = "Homos"
                cell.foodImageView?.image = UIImage(named: "Homos")
            case 2:
                cell.foodNameLabel.text = "Mix Grill"
                cell.foodImageView?.image = UIImage(named: "MixGrill")
            default:
                print("No more cells in this section")
            }
        case 2:
            switch indexPath.row {
            case 0:
                cell.foodNameLabel.text = "Shrimps"
                cell.foodImageView?.image = UIImage(named: "Shrimps")
            case 1:
                cell.foodNameLabel.text = "Sushi"
                cell.foodImageView?.image = UIImage(named: "Sushi")
            case 2:
                cell.foodNameLabel.text = "Smoked Salmon"
                cell.foodImageView?.image = UIImage(named: "Salmon")
            default:
                print("No more cells in this section")
            }
        default:
            print("No more sections")
        }
        return cell
    }

}
