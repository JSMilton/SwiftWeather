//
//  StoryboardExtensions.swift
//  SwiftWeather
//
//  Created by James Milton on 15/07/2014.
//  Copyright (c) 2014 James Milton. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    class func getViewControllerFromStoryboard(viewController:NSString, storyboard:NSString) -> UIViewController {
        let sBoard = UIStoryboard(name: storyboard, bundle: nil)
        let vController: UIViewController = sBoard.instantiateViewControllerWithIdentifier(viewController) as UIViewController
        return vController
    }
}
