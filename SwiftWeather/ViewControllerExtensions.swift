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
    
    func dismissModalViewControllerWithFade(fadeDuration:Double, completion:(()->Void)!){
        let vc = self.presentedViewController
        let tempView = UIView(frame: vc.view.frame)
        tempView.backgroundColor = self.view.backgroundColor
        tempView.alpha = 0
        vc.view.addSubview(tempView)
        UIView.animateWithDuration(fadeDuration/2, animations: {
            tempView.alpha = 1
        }, completion: {
            (b:Bool) in
            self.view.addSubview(tempView)
            self.dismissViewControllerAnimated(false, completion: {
                UIView.animateWithDuration(fadeDuration/2, animations: {
                    tempView.alpha = 0
                    }, completion:{
                        (b:Bool) in
                        if (completion){completion()}
                    })
            })
        })
    }
    
    func dismissModalViewControllerWithFadeAfterDelay(fadeDuration:Double, delayInSeconds:Double, completion:(()->Void)!){
        let delay = delayInSeconds * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.dismissModalViewControllerWithFade(fadeDuration, completion: completion)
        }
    }
    
    func presentViewControllerWithFade(vc:UIViewController, fadeDuration:Double, completion:(()->Void)!){
        let tempView = UIView(frame: vc.view.frame)
        tempView.backgroundColor = vc.view.backgroundColor
        tempView.alpha = 0
        self.view.addSubview(tempView)
        UIView.animateWithDuration(fadeDuration/2, animations: {
            tempView.alpha = 1
            }, completion: {
                (b:Bool) in
                vc.view.addSubview(tempView)
                self.presentViewController(vc, animated: false, completion: {
                    UIView.animateWithDuration(fadeDuration/2, animations: {
                        tempView.alpha = 0
                        }, completion:{
                            (b:Bool) in
                            if (completion){completion()}
                        })
                    })
            })
    }
    
    func presentViewControllerWithFadeAfterDelay(vc: UIViewController, fadeDuration:Double, delayInSeconds:Double, completion:(()->Void)!){
        let delay = delayInSeconds * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.presentViewControllerWithFade(vc, fadeDuration: fadeDuration, completion: completion)
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