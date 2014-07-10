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
    
    init()  {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
    }
    
    var block: ((CLLocation?)->Void)?
    
    func getUserLocation(completionBlock: ((CLLocation?)->Void)!) {
        locationManager.startUpdatingLocation()
        block = completionBlock
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if block {
            block!(locations[0] as? CLLocation)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)  {
        if block {
            block!(nil)
        }
        
        locationManager.stopUpdatingLocation()
    }
}