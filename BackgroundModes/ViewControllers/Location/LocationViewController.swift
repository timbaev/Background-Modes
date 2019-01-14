//
//  LocationViewController.swift
//  BackgroundModes
//
//  Created by Timur Shafigullin on 14/01/2019.
//  Copyright © 2019 Timur Shafigullin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var trackLocationSwitch: UISwitch!
    @IBOutlet fileprivate weak var mapView: MKMapView!
    
    // MARK: -
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate var locations: [CLLocationCoordinate2D] = []
    fileprivate var lastPolyline: MKPolyline?
    
    // MARK: - Instance Methods
    
    @IBAction func onTrackLocationSwitchValueChanged(_ sender: UISwitch) {
        Log.i(sender.isOn)
        
        if sender.isOn {
            self.locationManager.startUpdatingLocation()
        } else {
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    // MARK: -
    
    fileprivate func updatePolyline() {
        if let lastPolyline = self.lastPolyline {
            self.mapView.removeOverlay(lastPolyline)
        }
        
        let polyline = MKPolyline(coordinates: self.locations, count: self.locations.count)
        
        self.mapView.addOverlay(polyline)
        
        self.lastPolyline = polyline
    }
    
    // MARK: -
    
    fileprivate func apply() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.stopUpdatingLocation()
        
        if let userLocation = self.locationManager.location {
            let span = MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025)
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
            
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apply()
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationViewController: CLLocationManagerDelegate {
    
    // MARK: - Instance Methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            Log.i("Permission allow")
        } else {
            Log.w("Permission denied")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            Log.i("New location is \(location)")
            self.locations.append(location.coordinate)
            
            self.updatePolyline()
        }
    }
}

// MARK: - MKMapViewDelegate

extension LocationViewController: MKMapViewDelegate {
    
    // MARK: - Instance Methods
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRender = MKPolylineRenderer(overlay: overlay)
            
            polylineRender.strokeColor = UIColor.red.withAlphaComponent(0.5)
            polylineRender.lineWidth = 5
            
            return polylineRender
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
}
