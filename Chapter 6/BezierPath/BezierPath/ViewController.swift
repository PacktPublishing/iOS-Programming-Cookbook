//
//  ViewController.swift
//  BezierPath
//
//  Created by Hossam Ghareeb on 9/17/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let progressLineWidth: CGFloat = 20
    
    var progressiveLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.yellow
        let radius = 100
        let rect = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        let fixedLayer = getShapeLayerForRect(rect: rect, strokeColor: UIColor.black.withAlphaComponent(0.5))
        fixedLayer.bounds = fixedLayer.bounds.offsetBy(dx: -50, dy: -100)
        
        let progressiveLayer = getShapeLayerForRect(rect: rect, strokeColor: UIColor.black)
        progressiveLayer.shadowColor = UIColor.black.cgColor
        progressiveLayer.shadowRadius = 9.0
        progressiveLayer.shadowOpacity = 0.9
        progressiveLayer.shadowOffset = CGSize(width: 0, height: 0)
        progressiveLayer.bounds = fixedLayer.bounds
        progressiveLayer.strokeEnd = 0
        
        self.progressiveLayer = progressiveLayer
        self.view.layer.addSublayer(fixedLayer)
        self.view.layer.addSublayer(progressiveLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    private func getShapeLayerForRect(rect:CGRect, strokeColor sColor:UIColor) -> CAShapeLayer{
        
        let radius = rect.width / 2 - progressLineWidth / 2
        let newRect = CGRect(x: progressLineWidth / 2, y: progressLineWidth / 2, width: radius * 2, height: radius * 2)
        let path = UIBezierPath(roundedRect: newRect, cornerRadius: radius).cgPath
        let shape = CAShapeLayer()
        shape.path = path
        shape.strokeColor = sColor.cgColor
        shape.lineCap = kCALineCapRound
        shape.lineWidth = progressLineWidth
        shape.fillColor = nil
        return shape
    }
    
    @IBAction func didClickOnDownloadButton(_ sender: AnyObject) {
        
        self.progressiveLayer?.strokeEnd = 0.75
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 0.75
        animation.duration = 4
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.progressiveLayer?.add(animation, forKey: "progress")
    }
}

