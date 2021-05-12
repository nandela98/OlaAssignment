//
//  OlaAnnotation.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/12/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import MapKit
/**
   to Customize annotation
*/
final class OlaAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    var image: UIImage?
    
    /// init for custom MKAnnotation
    /// - Parameters:
    ///   - coordinate: pass latitude and logitudes
    ///   - title: title for the annotation
    ///   - image: custom image for annotation
    ///   - subTitle: subtitle for annotation
    init(coordinate: CLLocationCoordinate2D, title: String, image: UIImage, subTitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subTitle
        self.image = image
    }
    
}
