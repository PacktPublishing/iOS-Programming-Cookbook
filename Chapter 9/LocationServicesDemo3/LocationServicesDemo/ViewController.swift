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
        self.mapView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTestAnnotations()
    }

    func addTestAnnotations(){
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 60.1690368, longitude: 24.9370282)
        annotation1.title = "Stockmann"
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 60.1716389, longitude: 24.9405934)
        annotation2.title = "Aleksis Kiven"
        
        let annotation3 = MKPointAnnotation()
        annotation3.coordinate = CLLocationCoordinate2D(latitude: 60.17152, longitude: 24.9366044)
        annotation3.title = "Helsinki Music Centre"
        
        self.mapView.addAnnotations([annotation1, annotation2, annotation3])
        self.mapView.showAnnotations([annotation1, annotation2, annotation3], animated: true)
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
    
    @IBAction func didClickOnDirections(_ sender: AnyObject) {
        let mapItem1 = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 60.1690368, longitude: 24.9370282)))
        let mapItem2 = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 60.1716389, longitude: 24.9405934)))
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = mapItem1
        directionRequest.destination = mapItem2
        directionRequest.transportType = .walking
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            if let routingError = error{
                print(routingError)
            }
            else{
                if let directionsResponse = response{
                    for route in directionsResponse.routes{
                        self.mapView.add(route.polyline, level: .aboveRoads)
                    }
                }
            }
        }
    }
    func showLocationPermissionAlert(){
        self.locationManager.requestWhenInUseAuthorization()
        self.startUpdatingLocation()
    }

    func startUpdatingLocation(){
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    func showAlertWithMessage(message: String){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        
        if annotation.isKind(of: CustomAnnotation.self){
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CustomView")
            annotationView.image = UIImage(named: "car.png")
            return annotationView
        }else{
            var pinView: MKPinAnnotationView
            
            if let pv = mapView.dequeueReusableAnnotationView(withIdentifier: "PinView") as? MKPinAnnotationView{
                pinView = pv
                pinView.annotation = annotation
            }
            else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PinView")
                pinView.pinTintColor = UIColor.red
                pinView.animatesDrop = true
                pinView.canShowCallout = true
                
                let rightButton = UIButton(type: .detailDisclosure)
                pinView.rightCalloutAccessoryView = rightButton
                let imageView = UIImageView(image: UIImage(named: "icon.png"))
                pinView.leftCalloutAccessoryView = imageView
            }
            
            return pinView
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(view.annotation?.title)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay.isKind(of: MKPolyline.self){
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 5.0
            return renderer
        }
        return MKOverlayRenderer()
    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.first{
            if let annotation = self.myLocationAnnotation {
                self.mapView.removeAnnotation(annotation)
            }
            let annotation = CustomAnnotation(location: location.coordinate)
            annotation.title = "You're here!"
            self.myLocationAnnotation = annotation
            self.mapView.addAnnotation(annotation)
        }
    }
}

