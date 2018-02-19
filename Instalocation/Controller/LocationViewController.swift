//
//  LocationViewController.swift
//  Instalocation
//
//  Created by Soheil Malekzadeh on 2/18/18.
//  Copyright © 2018 Soheil Malekzadeh. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager: CLLocationManager = CLLocationManager()
    let distanceFilter: CLLocationDistance = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableBasicLocationServices()
    }
    
    func didUpdateLocation(_ location: CLLocation) {
        // Override this method when the device's location is needed.
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            break
        case .restricted, .denied:
            stopUpdatingLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.distanceFilter = distanceFilter
            startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            didUpdateLocation(location)
        }
    }
    
    private func enableBasicLocationServices() {
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied, .authorizedAlways, .authorizedWhenInUse:
            break
        }
    }
    
}
