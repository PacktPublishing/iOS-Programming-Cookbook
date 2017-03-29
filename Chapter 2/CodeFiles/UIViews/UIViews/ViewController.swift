//
//  ViewController.swift
//  UIViews
//
//  Created by Hossam Ghareeb on 6/25/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var circularProgressView: CircularProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let yellowView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        yellowView.backgroundColor = UIColor.yellow
        self.redView.addSubview(yellowView)
        
        let brownView = UIView(frame: CGRect(x: 100, y: 50, width: 200, height: 100))
        brownView.backgroundColor = UIColor.brown
        self.redView.insertSubview(brownView, belowSubview: yellowView)
//        self.redView.insertSubview(view, atIndex: 2)
//        self.redView.insertSubview(view, aboveSubview: superview)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.circularProgressView.updateProgess(0.75, animated: true, duration: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

