//
//  GeoFenceData.swift
//  LocationServicesDemo
//
//  Created by Hossam Ghareeb on 11/11/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class GeoFenceData: NSObject {

    var notes:String
    var radius:Double
    var latitude:Double
    var longitude:Double
    var notifyOnEntry:Bool
    var identifier: Int
    
    init(notes: String, radius: Double, latitude lat: Double, longitude lot: Double, notifyOnEntry: Bool, identifier: Int) {
        self.notes = notes
        self.radius = radius
        self.latitude = lat
        self.longitude = lot
        self.notifyOnEntry = notifyOnEntry
        self.identifier = identifier
    }
}
