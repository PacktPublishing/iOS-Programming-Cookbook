//
//  ImagesViewController.swift
//  OnDemandDemo
//
//  Created by Hossam Ghareeb on 1/30/17.
//  Copyright © 2017 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    var selectedCity: String?
    
    var resourceRequest: NSBundleResourceRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let city = self.selectedCity{
            let tags = NSSet(object: city)
            resourceRequest = NSBundleResourceRequest(tags: tags as! Set<String>)
            
            // Request access to tags that may already be on the device
            resourceRequest?.conditionallyBeginAccessingResources(completionHandler: { (resourcesAvailable) in
                
                if resourcesAvailable{
                    // the associated resources are loaded, start using them
                    OperationQueue.main.addOperation {
                        self.displayImages()
                    }
                }
                else{
                    // The resources are not on the device and need to be loaded
                    self.resourceRequest?.beginAccessingResources(completionHandler: { (error) in
                        if (error != nil){
                            return
                        }
                        OperationQueue.main.addOperation {
                            self.displayImages()
                        }
                    })
                }
            })
        }
        
    }

    func  displayImages(){
        if let city = self.selectedCity{
            let imgName = city == "dubai" ? "D" : "AD"
            self.imageView1.image = UIImage(named: "\(imgName)1")
            self.imageView2.image = UIImage(named: "\(imgName)2")
            self.imageView3.image = UIImage(named: "\(imgName)3")
            self.imageView4.image = UIImage(named: "\(imgName)4")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
