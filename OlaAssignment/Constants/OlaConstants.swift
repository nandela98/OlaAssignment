//
//  OlaConstants.swift
//  Assignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation
import UIKit

/// constants for across the app
struct OlaConstants {
    
    /// Notification Constants
    struct NotificationConstants {
        static let ShowInternetPopup = NSNotification.Name(rawValue: "showInternetPopup")
    }
    
    /// For the bottom sheet pull - view height adjustments
    static var partialVisibleView = UIScreen.main.bounds.height - 200
    static var fullVisibleView: CGFloat = 150
    
    /// mapview identifier
    static let annotationViewIdentifier = "olaAnnotationView"
    
}
