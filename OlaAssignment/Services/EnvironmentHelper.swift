//
//  EnvironmentHelper.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation

/// return the baseUrl - based on the environment 
struct EnvironmentHelper {
    
    func getBaseUrl(service: ServiceType) -> String {
        switch service {
        case .getVehicleData:
            return baseURL()
        }
    }
    
    func baseURL() -> String {
        return "http://www.mocky.io/" + getUrlVersion()
    }
    
    func getUrlVersion() -> String {
        return "v2/"
    }
    
}
