//
//  MapView+VisibleRect.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import MapKit

extension MKMapView {
    
    /**
       Zoom To fit all pins to visible rect
     */
    func setVisibleMapRectToFitAllAnnotations(animated: Bool = false,
                                              shouldIncludeUserAccuracyRange: Bool = true,
                                              shouldIncludeOverlays: Bool = true,
                                              edgePadding: UIEdgeInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)) {
        var mapOverlays = overlays
        if shouldIncludeUserAccuracyRange, let userLocation = userLocation.location {
            let userAccuracyRangeCircle = MKCircle(center: userLocation.coordinate, radius: userLocation.horizontalAccuracy)
            mapOverlays.append(MKOverlayRenderer(overlay: userAccuracyRangeCircle).overlay)
        }
        if shouldIncludeOverlays {
            let annotations = self.annotations.filter { !($0 is MKUserLocation) }
            annotations.forEach { annotation in
                let cirlce = MKCircle(center: annotation.coordinate, radius: 1)
                mapOverlays.append(cirlce)
            }
        }
        let zoomRect = MKMapRect(bounding: mapOverlays)
        setVisibleMapRect(zoomRect, edgePadding: edgePadding, animated: animated)
    }
    
}

extension MKMapRect {
    
    init(bounding overlays: [MKOverlay]) {
        self = .null
        overlays.forEach { overlay in
            let rect: MKMapRect = overlay.boundingMapRect
            self = self.union(rect)
        }
    }
    
}

