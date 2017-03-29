//
//  StartViewController.swift
//  PagesVC
//
//  Created by Hossam Ghareeb on 8/31/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedRoot"{
            let rootViewController = segue.destination as! RootViewController
            // do any setup here for rootViewController
            print(rootViewController)
        }
    }


}
