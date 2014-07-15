//
//  ViewControllerExtensions.swift
//  SwiftWeather
//
//  Created by James Milton on 10/07/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func dismissModalViewControllerAfterDelay(delayInSeconds: Double, completion:(()->Void)!) {
        let delay = delayInSeconds * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(true, completion: completion)
        }
    }
    
    func performSegueAfterDelay(delayInSeconds: Double, identifier:NSString) {
        let delay = delayInSeconds * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.performSegueWithIdentifier(identifier, sender: nil);
        }
    }
}