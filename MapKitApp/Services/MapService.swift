//
//  MapService.swift
//  MapKitApp
//
//  Created by Rynat Shakirov on 31.01.2025.
//

import Foundation
import MapKit

class MapService {
    static let shared = MapService()
    private init() {}
    
    
    func deleteExistingAnnotations(from mapView: MKMapView) {
        if let annotations = mapView.annotations as? [MKAnnotation]{
            mapView.removeAnnotations(annotations)
        }
    }
    
    func updateLocationOnMap(to location: CLLocation,mapView: MKMapView,with title: String?) {
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        deleteExistingAnnotations(from: mapView)
        mapView.addAnnotation(point)
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(region, animated: true)
        
    }
}
