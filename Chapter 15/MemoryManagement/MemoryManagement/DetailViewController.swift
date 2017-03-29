//
//  DetailViewController.swift
//  MemoryManagement
//
//  Created by Hossam Ghareeb on 1/29/17.
//  Copyright © 2017 Hossam Ghareeb. All rights reserved.
//

import UIKit

class Child{
     weak var parent: UIViewController?
}

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    let child = Child()

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.child.parent = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

