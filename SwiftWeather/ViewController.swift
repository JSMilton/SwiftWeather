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
    let FADE_DURATION = 0.5
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
        let loadingView = UIStoryboard.getViewControllerFromStoryboard("LoadingScreen", storyboard: "Main") as LoadingViewController
        self.presentViewControllerWithFade(loadingView, fadeDuration: self.FADE_DURATION) {
            LocationManager.sharedInstance.getUserLocation(){
                (location: CLLocation?) in
                if let loc = location {
                    WeatherData.getWeatherDataForLocation(loc) {
                        (data: WeatherData?) in
                        if let d = data {
                            self.setupUIWithWeatherData(d)
                            self.dismissModalViewControllerWithFadeAfterDelay(self.FADE_DURATION, delayInSeconds: 2.5, completion: nil)
                        } else {
                            self.dismissModalViewControllerWithFadeAfterDelay(self.FADE_DURATION, delayInSeconds: 2.5){
                                self.showErrorScreen()
                            }
                        }
                    }
                } else {
                    println("error getting user location, no weather data collected")
                    self.dismissModalViewControllerWithFadeAfterDelay(0.5, delayInSeconds: 2.5){
                        self.showErrorScreen()
                    }
                }
            }
        }
    }
    
    func showErrorScreen() {
        let errorView = UIStoryboard.getViewControllerFromStoryboard("ErrorScreen", storyboard: "Main") as ErrorViewController
        errorView.dismissGesture.addTarget(self, action: "dismissErrorScreen")
        self.presentViewControllerWithFade(errorView, fadeDuration: self.FADE_DURATION, completion: nil)
        self.shouldRefreshData = true
    }
    
    func dismissErrorScreen() {
        self.dismissModalViewControllerWithFade(self.FADE_DURATION, completion: nil)
    }
    
    func setupUIWithWeatherData(data: WeatherData){
        println("set me up")
    }
}