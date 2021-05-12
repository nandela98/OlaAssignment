//
//  OlaVehicleMainViewController.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import CoreLocation

final class OlaVehicleMainViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    /// view model for service calls and logic handling
    private var viewModel: OlaVehicleViewModelType? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVehicleData()
    }
    
}

// MARK: fileprivate (Setup - Bottomsheet / MapView)

fileprivate extension OlaVehicleMainViewController {
    
    /// fetch vehicles data from server on load of VC
    func fetchVehicleData() {
        showLoader()
        viewModel = OlaVehicleViewModel(view: self)
        viewModel?.getAvailableVehicles()
    }
    
    /// on success of fetching data - load mapView
    func setupAndLoadMapView() {
        registerAnnotationIdentifierForMapView()
        loadPinsOnMap()
    }
    
    /// register Annotation Identifier For MapView
    func registerAnnotationIdentifierForMapView() {
        mapView.register(OlaAnnotationView.self, forAnnotationViewWithReuseIdentifier: OlaConstants.annotationViewIdentifier)
    }
    
    /// loop over list of vehicles response and loading all pins on map.
    func loadPinsOnMap() {
       _ = viewModel?.vehicles.map { vehicles in
            vehicles.map { vehicle in
                addAnnotationToMapView(vehicle)
            }
        }
        zoomToVisibleVehiclesRect()
    }
    
    /// adding annotations to mapView for all available vehicles in response
    /// - Parameter vehicle: server model after looping from server response
    func addAnnotationToMapView(_ vehicle: Vehicle) {
        let annotation = OlaAnnotation(
            coordinate: CLLocationCoordinate2D(latitude: vehicle.location?.latitude ?? 0.0, longitude: vehicle.location?.longitude ?? 0.0),
            title: (vehicle.vehicleDetails?.make?.rawValue ?? "") + " " + (vehicle.vehicleDetails?.name ?? ""),
            image: UIImage(named: "car")!,
            subTitle: vehicle.vehicleDetails?.series?.rawValue ?? ""
        )
        mapView.addAnnotation(annotation)
    }
    
    /// zoom mapview to all vehicles visible rect
    func zoomToVisibleVehiclesRect() {
        mapView.setVisibleMapRectToFitAllAnnotations()
    }
    
    /// add bottom sheet for vehicles to display after grouping based on model of vehicle
    func addBottomSheetView() {
        if let vehicleData = viewModel?.getVehiclesBasedOnGroupType()
        {
            let bottomSheetVC = OlaVehiclesSheetViewController(data: vehicleData)
            addChild(bottomSheetVC)
            view.addSubview(bottomSheetVC.view)
            bottomSheetVC.didMove(toParent: self)
            let height = view.frame.height
            let width  = view.frame.width
            bottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
        }
    }
    
}


// MARK: View model output delegates

extension OlaVehicleMainViewController: OlaVehicleViewModelProtocol {
    
    func didFetchVehiclesData() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoader()
            self?.setupAndLoadMapView()
            self?.addBottomSheetView()
        }
    }
    
    func didFailedToFetchData(_ error: ErrorResult?) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoader()
            showAlert(message: error?.localizedDescription ?? "", completion: {_ in })
        }
    }
    
}



// MARK: MKMapViewDelegate

extension OlaVehicleMainViewController: MKMapViewDelegate {
    /// for setting custom viewFor annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: OlaConstants.annotationViewIdentifier, for: annotation) as? OlaAnnotationView, let carAnnotation = annotation as? OlaAnnotation {
            annotationView.image = carAnnotation.image
            return annotationView
        }
        return nil
    }
    
}
