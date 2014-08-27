//
//  WeatherDataFactory.swift
//  SwiftWeather
//
//  Created by James Milton on 16/07/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

import Foundation

class WeatherDataFactory {
    class func createCurrentWeatherDataObject(data:NSDictionary) -> WeatherData {
        var locationName = data["name"] as NSString
        var currentTemp = data.valueForKeyPath("main.temp") as Double
        var highTemp = data.valueForKeyPath("main.temp_max") as Double
        var lowTemp = data.valueForKeyPath("main.temp_min") as Double
        var windSpeed = data.valueForKeyPath("wind.speed") as Double
        var windDirection = data.valueForKeyPath("wind.deg") as Double
        var description = ((data["weather"] as NSArray)[0] as NSDictionary).valueForKeyPath("description") as NSString
        var icon = ((data["weather"] as NSArray)[0] as NSDictionary).valueForKeyPath("icon") as NSString
        
        return WeatherData(locationName: locationName, currentTemp: currentTemp, highTemp: highTemp, lowTemp: lowTemp, windSpeed: windSpeed, windDirection: windDirection, description: description, icon: icon)
    }
    
    class func createForecastWeatherDataArray(data:NSDictionary) -> NSArray {
        let dailyData:NSArray = data["list"] as NSArray
        var dataToReturn = [WeatherData]()
        for value in dailyData {
            var dict = value as NSDictionary
            var locationName = data.valueForKeyPath("city.name") as NSString
            var currentTemp = 0.0
            var highTemp = dict.valueForKeyPath("temp.max") as Double
            var lowTemp = dict.valueForKeyPath("temp.min") as Double
            var windSpeed = dict.valueForKeyPath("speed") as Double
            var windDirection = dict.valueForKeyPath("deg") as Double
            var description = ((dict["weather"] as NSArray)[0] as NSDictionary).valueForKeyPath("description") as NSString
            var icon = ((dict["weather"] as NSArray)[0] as NSDictionary).valueForKeyPath("icon") as NSString

            dataToReturn.append(WeatherData(locationName: locationName, currentTemp: currentTemp, highTemp: highTemp, lowTemp: lowTemp, windSpeed: windSpeed, windDirection: windDirection, description: description, icon: icon))
        }
        
        return dataToReturn
    }
}