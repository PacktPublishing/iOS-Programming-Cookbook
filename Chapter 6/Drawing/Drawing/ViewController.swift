//
//  ViewController.swift
//  Drawing
//
//  Created by Hossam Ghareeb on 9/16/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

extension UIView{
    
    var screenshot: UIImage{
        
        UIGraphicsBeginImageContext(self.bounds.size);
        let context = UIGraphicsGetCurrentContext();
        self.layer.render(in: context!)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return screenShot!
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var customView: CustomView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func didClickOnSaveButton(_ sender: AnyObject) {
        let image = self.customView.screenshot
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    @IBAction func didChangeSliderValue(_ sender: UISlider) {
        customView.satisfaction = CGFloat(sender.value)
    }
}

