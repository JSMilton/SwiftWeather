//
//  ViewController.swift
//  SwiftWeather
//
//  Created by James Milton on 20/06/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class ViewController: UIViewController, NSURLConnectionDataDelegate {
    var shouldRefreshData: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.shouldRefreshData {
            refresh()
            self.shouldRefreshData = false
        }
    }
    
    func refresh() {
        self.performSegueWithIdentifier("LoadingSegue", sender: nil)
        LocationManager.sharedInstance.getUserLocation(){
            (location: CLLocation?) in
            if let loc = location {
                WeatherData.getWeatherDataForLocation(loc) {
                    (data: WeatherData?) in
                    if let d = data {
                        // setup ui with weather data
                        self.setupUIWithWeatherData(d)
                    } else {
                        // show error screen
                    }
                    
                    self.dismissModalViewControllerAfterDelay(2.5)
                }
            } else {
                println("error getting user location, no weather data collected")
                self.dismissModalViewControllerAfterDelay(2.5)
            }
        }
    }
    
    func setupUIWithWeatherData(data: WeatherData){
        println("set me up")
    }
}