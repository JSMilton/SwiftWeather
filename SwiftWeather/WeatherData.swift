//
//  WeatherData.swift
//  SwiftWeather
//
//  Created by James Milton on 10/07/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

/*

    Location name
    Current temp    
    High / Low temp
    Wind speed / direction
    Description
    Icon url
*/

import Foundation
import CoreLocation

class WeatherData {
    class func getCurrentWeatherDataForLocation(location: CLLocation, completionBlock: ((WeatherData?)->Void)!){
        var request: NSURLRequest? = NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=metric"), cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        var dataToReturn: WeatherData? = nil
        let apiClient = ApiClient()
        apiClient.getJSONData(request){
            (data:NSDictionary?, error:NSError?) in
            if let e = error {
                println(e)
            } else {
                println(data)
                dataToReturn = WeatherDataFactory.createCurrentWeatherDataObject(data!)
            }
            
            if let cb = completionBlock {
                cb(dataToReturn)
            }
        }
    }
    
    class func getForecastWeatherDataForLocation(location: CLLocation, days: Int, completionBlock: ((NSArray?)->Void)!){
        var request: NSURLRequest? = NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&cnt=\(days)&mode=json&units=metric"), cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        var dataToReturn: NSArray? = nil
        let apiClient = ApiClient()
        apiClient.getJSONData(request){
            (data:NSDictionary?, error:NSError?) in
            if let e = error {
                println(e)
            } else {
                dataToReturn = WeatherDataFactory.createForecastWeatherDataArray(data!)
            }
            
            if let cb = completionBlock {
                cb(dataToReturn)
            }
        }
    }

    func getWindDirectionFromDegrees(deg:Double) -> NSString{
        switch deg {
        case 0...22.25:
            return "N"
        case 22.5...67.5:
            return "NE"
        case 67.5...112.5:
            return "E"
        case 112.5...157.5:
            return "SE"
        case 157.5...202.5:
            return "S"
        case 202.5...247.5:
            return "SW"
        case 247.5...292.5:
            return "W"
        case 292.5...337.5:
            return "NW"
        case 337.5...360:
            return "N"
        default:
            return ""
        }
    }
    
    var locationName:NSString!
    var currentTemp:Double!
    var highTemp:Double!
    var lowTemp:Double!
    var windSpeed:Double!
    var windDirection:NSString!
    var description:NSString!
    var iconURL:NSString!
    
    init(locationName:NSString, currentTemp:Double, highTemp:Double, lowTemp:Double, windSpeed:Double, windDirection:Double, description:NSString, icon:NSString)
    {
        self.locationName = locationName
        self.currentTemp = currentTemp
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.windSpeed = windSpeed
        self.windDirection = getWindDirectionFromDegrees(windDirection)
        self.description = description
        self.iconURL = "http://blah.com?icon=\(icon)"
    }
}



