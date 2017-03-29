//
//  GeofencingViewController.swift
//  LocationServicesDemo
//
//  Created by Hossam Ghareeb on 11/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import MapKit

class GeofencingViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    var currentAnnotation: MKPointAnnotation?
    var currentCircle: MKCircle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.distanceTextField.addTarget(self, action: #selector(GeofencingViewController.didChangeDistanceValue(sender:)), for: .editingChanged)
        self.mapView.delegate = self
        // Tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GeofencingViewController.didTapOnMapView(gesture:)))
        tapGesture.numberOfTapsRequired = 1
        self.mapView.addGestureRecognizer(tapGesture)
        
    }
    
    func didTapOnMapView(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: self.mapView)
        let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
        if let currentAnnotation = self.currentAnnotation{
            self.mapView.removeAnnotation(currentAnnotation)
        }
        self.currentAnnotation = MKPointAnnotation()
        self.currentAnnotation?.coordinate = coordinate
        self.mapView.addAnnotation(self.currentAnnotation!)
    }
    
    func didChangeDistanceValue(sender: UITextField) {
        if let text = sender.text {
            let distance = (text as NSString).doubleValue
            showCircleWithRadius(radius: distance)
        }
    }
    
    func showCircleWithRadius(radius: Double) {
        if let annotation = self.currentAnnotation {
            if let circle = self.currentCircle {
                self.mapView.remove(circle)
            }
            if radius > 0 {
                let circle = MKCircle(center: annotation.coordinate, radius: radius)
                self.mapView.addOverlays([circle])
                self.currentCircle = circle
            }
        }
        
    }
    
    @IBAction func didClickOnSaveButton(_ sender: AnyObject) {
        if let annotation = self.currentAnnotation, let circle = self.currentCircle, let text = self.notesTextView.text {
            
            // All data are available. 
            let maxId = UserDefaults.standard.integer(forKey: "GeoFenceId")
            UserDefaults.standard.set(maxId + 1, forKey: "GeoFenceId")
            UserDefaults.standard.set(text, forKey: "Fence\(maxId)")
            
            let geoFence = GeoFenceData(notes: text, radius: circle.radius, latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude, notifyOnEntry: self.segmentedControl.selectedSegmentIndex == 0, identifier: maxId)
            
            startMonitoringGeoFence(fence: geoFence)
        }
    }
    
    func regionFromGeoFence(fence: GeoFenceData) -> CLCircularRegion {
        
        let region = CLCircularRegion(center: CLLocationCoordinate2DMake(fence.latitude, fence.longitude), radius: fence.radius, identifier: "Fence\(fence.identifier)")
        
        region.notifyOnEntry = fence.notifyOnEntry
        region.notifyOnExit = !fence.notifyOnEntry
        return region
    }
    
    func startMonitoringGeoFence(fence:GeoFenceData) {
        
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            print("Geofencing is not supported on this device!")
            return
        }
        
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            
            print("Your geotification is saved but will only be activated once you grant Geotify permission to access the device location.")
        }
        else {
            let region = regionFromGeoFence(fence: fence)
            let locationManager = CLLocationManager()
            locationManager.startMonitoring(for: region)
        }
    }
}

extension GeofencingViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.fillColor = UIColor.red.withAlphaComponent(0.6)
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.view.endEditing(true)
    }
}
