//
//  UserLocationService.swift
//  MapKitApp
//
//  Created by Rynat Shakirov on 30.01.2025.
//

import Foundation
import CoreLocation

protocol UserLocationServiceDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation)
}

class UserLocationService: NSObject, CLLocationManagerDelegate {
    
    weak var delegate : UserLocationServiceDelegate?
    
    static let shared = UserLocationService() // Singleton instance
        
        private var locationManager: CLLocationManager // Property to store CLLocationManager instance
        
        private override init() {
            locationManager = CLLocationManager() // Initialize locationManager
            super.init() // Call superclass init
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    
    func getLastKnownLocation() -> CLLocation? {
        return locationManager.location
    }
    
    func requestLocationPermission() {
           locationManager.requestWhenInUseAuthorization()
       }
       
       // Start location updates
    func startUpdatingLocation() {
           locationManager.startUpdatingLocation()
       }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
            }
        }
        
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate?.didUpdateLocation(location)
        }
    
    }

