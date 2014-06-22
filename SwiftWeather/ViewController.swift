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
        // Do any additional setup after loading the view, typically from a nib.
        test({
            (s:String) in
            println(s)
            println("sdgjhcvd")
        })
        
        var request = NSURLRequest(URL: NSURL(string: "http://james-milton.com/mvf-testfeeds/GetAccountInfo.json"), cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        
        let connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
    }
    
    func test(block: ((String) -> Void)!)  {
        block("hello")
    }
    
    func connection(connection: NSURLConnection!,
        didReceiveResponse response: NSURLResponse!) {
            println(response)
    }
    
    func connection(connection: NSURLConnection!,
        didReceiveData data: NSData!) {
            receivedData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        println("hurrah, I've finished downloading!")
        let dict = NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        println(dict)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

