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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.performSegueWithIdentifier("LoadingSegue", sender: nil)
//        var request: NSURLRequest? = NSURLRequest(URL: NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=London,uk"), cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
//        let apiClient:ApiClient = ApiClient()
//        apiClient.getJSONData(request, completionBlock: {
//            (data:NSDictionary?, error:NSError?) in
//            if let e = error {
//                println(e)
//            } else {
//                println(data)
//            }
//            self.dismissViewControllerAnimated(true, completion: nil)
//        })
    }
}