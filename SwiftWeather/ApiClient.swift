//
//  ApiClient.swift
//  SwiftWeather
//
//  Created by James Milton on 22/06/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

import Foundation

class ApiClient: NSObject, NSURLConnectionDelegate {
    var receivedData: NSMutableData = NSMutableData(capacity: 0)
    var block: ((NSDictionary?, NSError?) -> (Void))?
    
    func getJSONData(request: NSURLRequest!, completionBlock: ((NSDictionary?, NSError?) -> Void)!){
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        block = completionBlock
    }
    
    func connection(connection: NSURLConnection!,
        didReceiveResponse response: NSURLResponse!) {
            let httpResponse = response as NSHTTPURLResponse
            if httpResponse.statusCode != 200 {
                block!(nil, NSError(domain: "API Client Error - No welcome message received from server", code: httpResponse.statusCode, userInfo: nil))
            } else {
                 println("API Client: Welcome message received - \(httpResponse.statusCode)")
            }
    }
    
    func connection(connection: NSURLConnection!,
        didReceiveData data: NSData!) {
            receivedData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        let dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        block!(dict, nil)
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("API Client: Request Failed - \(error.localizedDescription)")
        block!(nil, error)
    }
}