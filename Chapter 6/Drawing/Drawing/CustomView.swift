//
//  CustomView.swift
//  Drawing
//
//  Created by Hossam Ghareeb on 9/16/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class CustomView: UIView {

    var satisfaction: CGFloat = 0.5{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let context = UIGraphicsGetCurrentContext(){
            let yellow = UIColor.yellow
            context.setFillColor(yellow.cgColor)
            context.fill(self.bounds)
            
            // Drawing the face.
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(3.0)
            let radius = min(rect.width, rect.height) * 0.75 / 2
            context.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: false)
            
            // Gradient color
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let componentCount : Int = 2
            
            let components : [CGFloat] = [
                0.0, 1.0, 0.0, 1.0,
                0.0, 0.0, 1.0, 1.0
            ]
            
            let locations : [CGFloat] = [0, 1]
            
            let gradient = CGGradient(colorSpace: colorSpace, colorComponents: components, locations: locations, count: componentCount)
            context.drawLinearGradient(gradient!, start: CGPoint.zero, end: CGPoint(x: rect.maxX, y: rect.maxY), options: .drawsBeforeStartLocation)
            
            context.strokePath()
            
            /// Drawing Eyes
            // Left eye
            context.addArc(center: CGPoint(x: rect.midX - radius / 2, y: rect.midY - radius / 2), radius: 4.0, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: false)
            
            // Right eye
            context.addArc(center: CGPoint(x: rect.midX + radius / 2, y: rect.midY - radius / 2), radius: 4.0, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: false)
            
            let noseSize = CGSize(width: 4, height: 16)
            context.addRect(CGRect(x: rect.midX - noseSize.width / 2, y: rect.midY - noseSize.height / 2, width: noseSize.width, height: noseSize.height))
            
            context.setFillColor(UIColor.red.cgColor)
            context.fillPath()
            let startPoint = CGPoint(x: rect.midX - radius / 2, y: rect.midY + radius / 2)
            let endPoint = CGPoint(x: rect.midX + radius / 2, y: startPoint.y)
            context.move(to: startPoint)
            let cp = CGPoint(x: rect.midX, y: (startPoint.y) * (satisfaction + 0.5))
            context.addQuadCurve(to: endPoint, control: cp)
            // Filling
            context.strokePath()
            
            var status: NSString
            switch satisfaction {
            case let val where val == 0.5:
                status = "Neutral"
            case let val where val < 0.5:
                status = "Sad"
            default:
                status = "Happy"
            }
            status.draw(at: CGPoint(x: 5, y: 5), withAttributes: nil)
            
        }
    }
 
}
