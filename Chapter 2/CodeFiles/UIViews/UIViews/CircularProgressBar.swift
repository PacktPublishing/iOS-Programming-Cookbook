//
//  CircularProgressBar.swift
//  UIViews
//
//  Created by Hossam Ghareeb on 25/06/16.
//  Copyright © 2016 Prototype Interactive. All rights reserved.
//

import UIKit


@IBDesignable
class CircularProgressBar: UIView {

    /// The background fixed color of progress bar
    @IBInspectable var progressFixedColor : UIColor = UIColor.white
    
    /// The progressive color
    @IBInspectable var progressColor : UIColor = UIColor.red
    
    /// The line width of the progress circle
    @IBInspectable var lineWidth:CGFloat = 5.0
    
    /// The layer where we draw the progressive animation.
    fileprivate var progressiveLayer : CAShapeLayer?
    

    func updateProgess(_ progress:CGFloat, animated:Bool, duration:CFTimeInterval){
        
        if self.progressiveLayer == nil{
            self.setNeedsDisplay()
        }
        if progress <= 1.0{
            
            self.progressiveLayer?.strokeEnd = progress
            if  animated {
                
                CATransaction.begin()
                
                let animation = CABasicAnimation(keyPath: "strokeEnd");
                animation.duration = duration
                animation.fromValue = NSNumber(value: 0.0 as Float)
                animation.toValue = NSNumber(value: Float(progress) as Float);
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                self.progressiveLayer?.add(animation, forKey: "animateStrokeEnd")
                CATransaction.commit()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let fixedLayer = getShapeLayerForRect(rect, strokeColor: progressFixedColor)
        fixedLayer.strokeEnd = 1.0
        
        self.layer.addSublayer(fixedLayer)
        
        let progressiveLayer = getShapeLayerForRect(rect, strokeColor: progressColor)
        progressiveLayer.strokeEnd = 0.0
        
        self.progressiveLayer = progressiveLayer
        
        self.layer.addSublayer(progressiveLayer)
        
    }
    
    
    fileprivate func getShapeLayerForRect(_ rect:CGRect, strokeColor sColor:UIColor) -> CAShapeLayer{
        
        let radius = rect.width / 2 - lineWidth / 2
        let newRect = CGRect(x: lineWidth / 2, y: lineWidth / 2, width: radius * 2, height: radius * 2)
        let path = UIBezierPath(roundedRect: newRect, cornerRadius: radius).cgPath
        let shape = CAShapeLayer()
        shape.path = path
        shape.strokeColor = sColor.cgColor
        shape.lineWidth = self.lineWidth
        shape.fillColor = nil
        return shape
    }
 

}
