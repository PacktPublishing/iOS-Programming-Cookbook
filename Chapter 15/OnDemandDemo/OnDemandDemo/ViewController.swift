//
//  ViewController.swift
//  OnDemandDemo
//
//  Created by Hossam Ghareeb on 1/29/17.
//  Copyright © 2017 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentCity = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didClickOnDubaiButton(_ sender: Any) {
        currentCity = "dubai"
        self.performSegue(withIdentifier: "showImages", sender: nil)
    }
    @IBAction func didClickonADButton(_ sender: Any) {
        currentCity = "abu-dhabi"
        self.performSegue(withIdentifier: "showImages", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImages" {
            if let destinationViewController = segue.destination as? ImagesViewController{
                destinationViewController.selectedCity = currentCity
            }
        }
    }
}

