//
//  LocationManager.swift
//  SwiftWeather
//
//  Created by James Milton on 09/07/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    class var sharedInstance: LocationManager {
        struct Singleton {
            static let instance = LocationManager()
        }
        return Singleton.instance
    }
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    func setup() {
        locationManager.delegate = self
    }
}