//
//  LocationService.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 28/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import CoreLocation

class LocationService: NSObject {
    let locationManager = CLLocationManager()
    
    static var location: CLLocationCoordinate2D?
    
    var completion: ((CLLocationCoordinate2D?) -> Void)?
    
    override init() {
        super.init()
        
//        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
    func getLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        if let location = LocationService.location {
            completion(location)
            return
        }
        
        self.completion = completion
        
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        LocationService.location = locValue
        
     //   locationManager.stopUpdatingLocation()
        
        completion?(locValue)
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
