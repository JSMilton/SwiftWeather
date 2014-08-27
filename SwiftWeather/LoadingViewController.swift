//
//  LoadingViewController.swift
//  SwiftWeather
//
//  Created by James Milton on 09/07/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var timer: NSTimer!
    override func viewWillAppear(animated: Bool) {
        timer = NSTimer(timeInterval: 1.0, target: self, selector: "animate", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    func animate() {
        UIView.animateWithDuration(0.45, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.imageView.transform = self.rotateAndScale(0.8, angle: 3.14, transform: self.imageView.transform)
        }, completion: {(b: Bool) in
            UIView.animateWithDuration(0.45, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.imageView.transform = self.rotateAndScale(1.25, angle: 3.14, transform: self.imageView.transform)
            }, completion:nil)
        })
    }
    
    func rotateAndScale(scale: CGFloat, angle: CGFloat, transform: CGAffineTransform) -> CGAffineTransform {
        var currentTrans = transform
        currentTrans = CGAffineTransformRotate(currentTrans, angle)
        currentTrans = CGAffineTransformScale(currentTrans, scale, scale)
        return currentTrans
    }
}
