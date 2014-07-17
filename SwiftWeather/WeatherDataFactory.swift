//
//  WeatherDataFactory.swift
//  SwiftWeather
//
//  Created by James Milton on 16/07/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

import Foundation

class WeatherDataFactory {
    func createCurrentWeatherDataObject(data:NSDictionary) -> WeatherData {
        var locationName = data["name"] as NSString
        var currentTemp = data.valueForKeyPath("main.temp") as NSString
        var highTemp = data.valueForKeyPath("main.temp_max") as NSString
        var lowTemp = data.valueForKeyPath("main.temp_min") as NSString
        var windSpeed = data.valueForKeyPath("wind.speed") as NSString
        var windDirection = data.valueForKeyPath("wind.deg") as NSString
        var description = data.valueForKeyPath("weather.description") as NSString
        var icon = data.valueForKeyPath("weather.icon") as Int
        
        return WeatherData(locationName: locationName, currentTemp: currentTemp, highTemp: highTemp, lowTemp: lowTemp, windSpeed: windSpeed, windDirection: windDirection.floatValue, description: description, icon: icon)
    }
    
    func createForecastWeatherDataArray(data:NSDictionary) -> NSArray {
        let dailyData:NSArray = data["list"] as NSArray
        var dataToReturn = [WeatherData]()
        for value in dailyData {
            var dict = value as NSDictionary
            var locationName = data.valueForKeyPath("city.name") as NSString
            var currentTemp = ""
            var highTemp = dict.valueForKeyPath("temp.max") as NSString
            var lowTemp = data.valueForKeyPath("temp.min") as NSString
            var windSpeed = data.valueForKeyPath("speed") as NSString
            var windDirection = data.valueForKeyPath("deg") as Int
            var description = data.valueForKeyPath("weather.description") as NSString
            var icon = data.valueForKeyPath("weather.icon") as Int

            dataToReturn.append(WeatherData(locationName: locationName, currentTemp: currentTemp, highTemp: highTemp, lowTemp: lowTemp, windSpeed: windSpeed, windDirection: Float(windDirection), description: description, icon: icon))
        }
        
        return dataToReturn
    }
}