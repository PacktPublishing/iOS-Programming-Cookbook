//
//  ViewController.swift
//  Gestures
//
//  Created by Hossam Ghareeb on 6/26/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sampleView: UIView!
    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapGesture()
        
//        setupPanGesture()
        
        setupRotationGesture()
        
        setupSwipeGestures()
    }
    
    // MARK: - Swipe Gesture -
    
    func setupSwipeGestures() {
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        rightSwipeGesture.direction = .right
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        leftSwipeGesture.direction = .left
        
        self.sampleView.addGestureRecognizer(rightSwipeGesture)
        self.sampleView.addGestureRecognizer(leftSwipeGesture)
    }
    
    func handleSwipeGesture(_ swipeGesture: UISwipeGestureRecognizer) {
        
        var newXPosition : CGFloat = 0.0
        if swipeGesture.direction == .right {
            newXPosition = self.sampleView.frame.width
        }
        
        var frame = self.redView.frame
        frame.origin.x = newXPosition
        UIView.animate(withDuration: 0.5, animations: {
            self.redView.frame = frame
        }) 
    }
    
    // MARK: - Rotation Gesture -
    
    func setupRotationGesture() {
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotationGesture(_:)))
        self.sampleView.addGestureRecognizer(rotationGesture)
    }
    
    func handleRotationGesture(_ gesture: UIRotationGestureRecognizer) {
        
        self.sampleView.transform = self.sampleView.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
    
    // MARK: - Pan Gesture -
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.sampleView.addGestureRecognizer(panGesture)
    }
    
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        
        let point = gesture.location(in: self.view)
        self.sampleView.center = point
    }
    
    // MARK: - Tap Gesture -
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.numberOfTapsRequired = 2
        self.sampleView.addGestureRecognizer(tapGesture)
    }
    
    func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        var newHeight : CGFloat = 80.0
        if self.sampleView.frame.height == 80 {
            newHeight = 200.0
        }
        
        var frame = self.sampleView.frame
        frame.size.height = newHeight
        
        self.sampleView.frame = frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

