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
            self.performSegueWithIdentifier("LoadingSegue", sender: nil)
            LocationManager.sharedInstance.getUserLocation(){
                (location: CLLocation?) in
                if let loc = location {
                    var request: NSURLRequest? = NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(loc.coordinate.latitude)&lon=\(loc.coordinate.longitude)"), cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
                    ApiClient.sharedInstance.getJSONData(request){
                        (data:NSDictionary?, error:NSError?) in
                        if let e = error {
                            println(e)
                        } else {
                            println(data)
                        }
                        
                        self.shouldRefreshData = false
                        self.dismissModalViewControllerAfterDelay(2.5)
                    }
                } else {
                    println("error getting user location")
                    self.dismissModalViewControllerAfterDelay(2.5)
                }
            }
        }
    }
}