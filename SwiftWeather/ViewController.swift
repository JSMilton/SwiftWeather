//
//  ViewController.swift
//  SwiftWeather
//
//  Created by James Milton on 20/06/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, NSURLConnectionDataDelegate {
    var shouldShowingLoadingScreen: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.shouldShowingLoadingScreen {
            self.performSegueWithIdentifier("LoadingSegue", sender: nil)
        }
        var request: NSURLRequest? = NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=London,uk"), cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        let apiClient:ApiClient = ApiClient()
        apiClient.getJSONData(request, completionBlock: {
            (data:NSDictionary?, error:NSError?) in
            if let e = error {
                println(e)
            } else {
                println(data)
            }
            
            let delay = 4.5 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.dismissViewControllerAnimated(true, completion: nil)
                self.shouldShowingLoadingScreen = false
            }
        })
    }
}