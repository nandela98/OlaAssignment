//
//  OlaVehicleViewModel.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation

/// output viewmodel protocl to View
protocol OlaVehicleViewModelProtocol: class {
    func didFetchVehiclesData()
    func didFailedToFetchData(_ error: ErrorResult?)
}

protocol OlaVehicleViewModelType {
    var vehicles: [Vehicle]? { get set }
    func getAvailableVehicles()
    func getVehiclesBasedOnGroupType() -> [String : [Vehicle]]?
}

/// ola Main View controller - viewModel
final class OlaVehicleViewModel: OlaVehicleViewModelType {
    
    var vehicles: [Vehicle]?
    let olaService: OlaServiceProtocol
    weak var view: OlaVehicleViewModelProtocol?
    
    /// init with dependency - olaservice protocl and output view model protocol
    /// - Parameters:
    ///   - service: service is by default initialized - if needed, can pass required one
    ///   - view: output protocol of viewModel to view
    init(service: OlaServiceProtocol = OlaService(), view: OlaVehicleViewModelProtocol) {
        self.olaService = service
        self.view = view
     }
    
    /// fetching all available vehicles data from the server
    func getAvailableVehicles() {
        olaService.fetchVehicleData { [weak self] (result) in
            switch(result) {
            case .success(let vehicle):
                if let vehicleData = vehicle {
                    self?.vehicles = vehicleData
                    self?.view?.didFetchVehiclesData()
                }
                break;
            case .failure(let error):
                self?.view?.didFailedToFetchData(error)
                break;
            }
        }
    }
    
    /// to group all vehicles based on vehicle modelname
    /// - Returns: key as vehicle model name and value as array of Vehicle model data
    func getVehiclesBasedOnGroupType() -> [String : [Vehicle]]? {
        if let vehicles = vehicles {
            let vehiclesGroups = Dictionary(grouping: vehicles, by: { (element: Vehicle) in
                return element.modelName?.rawValue ?? ""
            })
            return vehiclesGroups
        }
        return nil
    }
    
}
