//
//  ViewController.swift
//  MapKitApp
//
//  Created by Rynat Shakirov on 30.01.2025.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,UserLocationServiceDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserLocationService.shared.delegate = self
        UserLocationService.shared.requestLocationPermission()
        UserLocationService.shared.startUpdatingLocation()
        
    }
    
    func didUpdateLocation(_ location: CLLocation) {
        DispatchQueue.main.async {
            MapService.shared.updateLocationOnMap(to: location, mapView: self.mapView, with: "Test Location")
        }
    }

    @IBAction func onLocationButtonTapped(_ sender: UIButton) {
        if let currentLocation = UserLocationService.shared.getLastKnownLocation() {
                didUpdateLocation(currentLocation)
            } else {
                print("Location is not available yet")
            }
        }
}

