//
//  OlaAnnotationView.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/12/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import MapKit

/**
    to Customize annotationView 
 */
final class OlaAnnotationView: MKAnnotationView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// init for custom MKAnnotationView
    /// - Parameters:
    ///   - annotation: annotation from viewForAnnotation delegate or someother
    ///   - reuseIdentifier: pass string to reuse the view
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        guard
            let observationAnnotation = self.annotation as? OlaAnnotation else {
            return
        }
        self.image = observationAnnotation.image
    }
    
}
