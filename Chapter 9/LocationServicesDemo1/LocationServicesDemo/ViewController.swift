//
//  ViewController.swift
//  LocationServicesDemo
//
//  Created by Hossam Ghareeb on 10/30/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    var myLocationAnnotation: MKAnnotation!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func didClickOnLocateMe(_ sender: AnyObject) {
        
        if CLLocationManager.locationServicesEnabled(){
            
            let status = CLLocationManager.authorizationStatus()
            switch status {
            case .denied, .restricted:
                self.showAlertWithMessage(message: "Your app is not authorized to use access user's location. Please check device Settings")
            case .notDetermined:
                self.showLocationPermissionAlert()
            default:
                /// App is authorized to get user location.
                self.startUpdatingLocation()
            }
        }
        else{
            showAlertWithMessage(message: "Location services is disabled. Please enable it from Settings.")
        }
    }
    
    func showLocationPermissionAlert() {
        self.locationManager.requestWhenInUseAuthorization()
        self.startUpdatingLocation()
    }
    
    func startUpdatingLocation(){
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    func showAlertWithMessage(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if let annotation = self.myLocationAnnotation {
                self.mapView.removeAnnotation(annotation)
            }
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = "You're here!"
            self.myLocationAnnotation = annotation
            self.mapView.addAnnotation(annotation)
        }
    }
}

