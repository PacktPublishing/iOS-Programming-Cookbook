//
//  FirstViewController.swift
//  PlayWithStoryboard
//
//  Created by Hossam Ghareeb on 8/15/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToFirstViewControllerFromRed(segue: UIStoryboardSegue) {
    
    }
    @IBAction func unwindToFirstViewControllerFromBlue(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindToFirstViewController(segue: UIStoryboardSegue) {
        
        
        if segue.source is RedViewController{
            
            print("Coming From Red!")
        }
        if segue.source is BlueViewController{
            print("Coming From Blue!")
        }
        
        
//        if segue.identifier == "comingFromRed"{
//            print("Coming From Red!")
//        }
//        if segue.identifier == "comingFromBlue" {
//            print("Coming From Blue!")
//        }
    }

}

