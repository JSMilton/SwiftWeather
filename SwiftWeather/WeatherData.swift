//
//  WeatherData.swift
//  SwiftWeather
//
//  Created by James Milton on 10/07/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherData {
    class func getWeatherDataForLocation(location: CLLocation, completionBlock: ((WeatherData?)->Void)!){
        var request: NSURLRequest? = NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"), cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        var dataToReturn: WeatherData? = nil
        let apiClient = ApiClient()
        apiClient.getJSONData(request){
            (data:NSDictionary?, error:NSError?) in
            if let e = error {
                println(e)
            } else {
                dataToReturn = WeatherData(locationData: data!)
            }
            
            if let cb = completionBlock {
                cb(dataToReturn)
            }
        }
    }
    
    init(locationData: NSDictionary){
        println(locationData)
    }
}