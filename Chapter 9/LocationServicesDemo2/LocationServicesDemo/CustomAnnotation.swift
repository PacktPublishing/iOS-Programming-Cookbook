//
//  CustomAnnotation.swift
//  LocationServicesDemo
//
//  Created by Hossam Ghareeb on 10/31/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String? = ""
    var color: UIColor
    override init() {
        coordinate = CLLocationCoordinate2D()
        color = UIColor.black
    }
    
    init(location: CLLocationCoordinate2D) {
        self.coordinate = location
        color = UIColor.black
    }
    init(location:CLLocationCoordinate2D, color: UIColor) {
        self.coordinate = location
        self.color = color
    }
}
