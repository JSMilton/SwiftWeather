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
    let FORECAST_NUMBER_OF_DAYS:Int = 7
    
    var shouldRefreshData: Bool = true
    var currentWeather:WeatherData!
    var forecastWeather:NSArray! // Array of WeatherData objects
    
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
                WeatherData.getCurrentWeatherDataForLocation(loc) {
                    (data: WeatherData?) in
                    if let d = data {
                        self.currentWeather = d
                        self.setupUIWithWeatherData(d)
                        self.dismissModalViewControllerAfterDelay(2.5, nil)
                        WeatherData.getForecastWeatherDataForLocation(loc, days: self.FORECAST_NUMBER_OF_DAYS) {
                            (data:NSArray?) in
                            if let d = data {
                                self.forecastWeather = d
                            }
                        }
                    } else {
                        self.dismissModalViewControllerAfterDelay(2.5) {
                            self.performSegueWithIdentifier("ErrorSegue", sender: nil)
                            self.shouldRefreshData = true
                        }
                    }
                }
            } else {
                println("error getting user location, no weather data collected")
                self.dismissModalViewControllerAfterDelay(2.5) {
                    self.performSegueWithIdentifier("ErrorSegue", sender: nil)
                    self.shouldRefreshData = true
                }
            }
        }
    }
    
    func setupUIWithWeatherData(data: WeatherData){
        println("set me up")
    }
}