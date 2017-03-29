//
//  ViewController.swift
//  GCDDemo
//
//  Created by Hossam Ghareeb on 10/9/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let url1 = "http://www.blirk.net/wallpapers/1280x720/kitten-wallpaper-17.jpg"
    let url2 = "http://www.blirk.net/wallpapers/1280x720/kitten-wallpaper-16.jpg"
    let url3 = "http://www.blirk.net/wallpapers/1280x720/kitten-wallpaper-15.jpg"
    let url4 = "http://www.blirk.net/wallpapers/1280x720/kitten-wallpaper-14.jpg"
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadImagesWithCustomOperations()
    }
    
    func loadImagesWithCustomOperations() {
        let queue = OperationQueue()
        queue.name = "LoadingQueue"
        self.addImageOperationToQueue(queue: queue, imgURL: URL(string: self.url1)!, imageView: self.imageView1)
        self.addImageOperationToQueue(queue: queue, imgURL: URL(string: self.url2)!, imageView: self.imageView2)
        self.addImageOperationToQueue(queue: queue, imgURL: URL(string: self.url3)!, imageView: self.imageView3)
        self.addImageOperationToQueue(queue: queue, imgURL: URL(string: self.url4)!, imageView: self.imageView4)
    }
    
    func addImageOperationToQueue(queue: OperationQueue, imgURL: URL, imageView: UIImageView) {
        let imageDownloader = ImageDownloader(imageURL: imgURL)
        imageDownloader.completionBlock = {
            OperationQueue.main.addOperation {
                if let img = imageDownloader.downloadedImage{
                    imageView.image = img
                }
            }
        }
        queue.addOperation(imageDownloader)
    }
    
    func loadImagesWithOperationQueues() {
        let queue = OperationQueue()
        queue.name = "Loading Images Queue"
        let operation1 = BlockOperation { 
            let data = try! Data(contentsOf: URL(string: self.url1)!)
            OperationQueue.main.addOperation {
                self.imageView1.image = UIImage(data: data)
            }
        }
        operation1.completionBlock = {
            print("Image 1 completed")
        }
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation {
            let data = try! Data(contentsOf: URL(string: self.url2)!)
            OperationQueue.main.addOperation {
                self.imageView2.image = UIImage(data: data)
            }
        }
        operation2.completionBlock = {
            print("Image 2 completed")
        }
        queue.addOperation(operation2)
        
        let operation3 = BlockOperation {
            let data = try! Data(contentsOf: URL(string: self.url3)!)
            OperationQueue.main.addOperation {
                self.imageView3.image = UIImage(data: data)
            }
        }
        operation3.completionBlock = {
            print("Image 3 completed")
        }
        queue.addOperation(operation3)
        
        let operation4 = BlockOperation {
            let data = try! Data(contentsOf: URL(string: self.url4)!)
            OperationQueue.main.addOperation {
                self.imageView4.image = UIImage(data: data)
            }
        }
        operation4.completionBlock = {
            print("Image 4 completed")
        }
        queue.addOperation(operation4)
    }
    
    func loadImages() {
        let queue = DispatchQueue.global(qos: .default)
//        let serialQueue = DispatchQueue(label: "serialQueue")
//        let concurrentQueue = DispatchQueue(label:"concurrentQueue", attributes: .concurrent)
        

        queue.async {
            let data = try! Data(contentsOf: URL(string: self.url1)!)
            DispatchQueue.main.async {
                self.imageView1.image = UIImage(data: data)
            }
        }
        
        queue.async {
            let data = try! Data(contentsOf: URL(string: self.url2)!)
            DispatchQueue.main.async {
                self.imageView2.image = UIImage(data: data)
            }
        }
        
        queue.async {
            let data = try! Data(contentsOf: URL(string: self.url3)!)
            DispatchQueue.main.async {
                self.imageView3.image = UIImage(data: data)
            }
        }

        queue.async {
            let data = try! Data(contentsOf: URL(string: self.url4)!)
            DispatchQueue.main.async {
                self.imageView4.image = UIImage(data: data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

