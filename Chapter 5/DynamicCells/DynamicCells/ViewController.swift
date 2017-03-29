//
//  ViewController.swift
//  DynamicCells
//
//  Created by Hossam Ghareeb on 9/9/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var demoTableView: UITableView!
    
    let titles = ["This is very simple title",
                  "Long text goes here\nLong text goes here\nLong text goes here\nLong text goes here\nLong text goes here\nLong text goes here",
                  "Some text goes here, Some text goes here, Some text goes here, Some text goes here, Some text goes here",
                  "Long text goes here\nLong text goes here\nLong text goes here\nLong text goes here\nLong text goes here\nLong text goes hereLong text goes here\nLong text goes here\nLong text goes here\nLong text goes here\nLong text goes here\nLong text goes hereLong text goes here\nLong text goes here\nLong text goes here\nLong text goes here\nLong text goes here\nLong text goes here"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        demoTableView.estimatedRowHeight = 43
        demoTableView.rowHeight = UITableViewAutomaticDimension
    }

}

extension ViewController: UITableViewDelegate{
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
}

