//
//  ScaleSegue.swift
//  PlayWithStoryboard
//
//  Created by Hossam Ghareeb on 8/24/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
class ScaleSegue: UIStoryboardSegue {

    override func perform() {
        
        if let fromView = self.source.view, let toView = self.destination.view{
            
            var frame = toView.frame
            let screenHeight = UIScreen.main.bounds.size.height
            let screenWidth = UIScreen.main.bounds.size.width
            
            frame.size = CGSize(width: 2 * screenWidth / 3, height: screenHeight / 2)
            toView.frame = frame
            
            if let window = UIApplication.shared.keyWindow{
                toView.center = window.center
                window.insertSubview(toView, aboveSubview: fromView)
                toView.transform = CGAffineTransform(scaleX: 0, y: 0)
                
                UIView.animate(withDuration: 0.5, animations: {
                    toView.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
            
        }
    }
}
