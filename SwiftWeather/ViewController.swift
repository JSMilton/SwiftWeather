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
    
    var receivedData: NSMutableData = NSMutableData(capacity: 0)
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = NSURLRequest(URL: NSURL(string: "http://james-milton.com/mvf-testfeeds/GetAccountInfo.json"), cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        
        let apiClient:ApiClient = ApiClient()
        apiClient.getJSONData(request, completionBlock: {
            (data:NSDictionary, error:NSError) in
                println(data)
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

