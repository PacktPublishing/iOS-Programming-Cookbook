//
//  ViewController.swift
//  3D Touch
//
//  Created by Hossam Ghareeb on 7/1/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var forceTouchLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == .available {
                    // 3D Touch is avaialble in this device
                    let force = touch.force / touch.maximumPossibleForce
                    self.forceTouchLabel.text = "\(force)%"
                }
            }
        }
    }

}

