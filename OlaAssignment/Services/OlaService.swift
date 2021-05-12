//
//  OlaService.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//
import Foundation

protocol OlaServiceProtocol {
    func fetchVehicleData(completion: @escaping(Result<[Vehicle]?, ErrorResult>) -> Void)
}
/// OlaService to fetch data from service 
final class OlaService: BaseService, OlaServiceProtocol, NetworkingManager {
    
    func fetchVehicleData(completion: @escaping(Result<[Vehicle]?, ErrorResult>) -> Void) {
        makeRequest(.getVehicleData, parameters: nil, body: nil, httpMethod: .get, httpHeaders: getHeaderParameters(), decode: { (json) -> [Vehicle]? in
            guard let result = json as? [Vehicle] else {
                return nil
            }
            return result
        }, completion: completion)
    }
    
}
