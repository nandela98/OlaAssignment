//
//  Vehicle.swift
//  Assignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation

struct Vehicles: Codable {
    var vehicle: [Vehicle]?
}

struct Vehicle: Codable {
    let id: String
    let modelIdentifier: String
    let modelName: Group
    let group: Group
    let licensePlate: String
    let innerCleanliness: InnerCleanliness
    let carImageURL: String
    let vehicleDetails: VehicleDetails
    let location: Location

    enum CodingKeys: String, CodingKey {
        case id, modelIdentifier, modelName, group, licensePlate, innerCleanliness
        case carImageURL = "carImageUrl"
        case vehicleDetails, location
    }
}

enum Group: String, Codable {
    case groupLUX = ":LUX"
    case lux = "LUX"
    case mini = "MINI"
    case prime = "PRIME"
}

enum InnerCleanliness: String, Codable {
    case lux = "LUX"
    case regular = "REGULAR"
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}

// MARK: - VehicleDetails
struct VehicleDetails: Codable {
    let name: String
    let make: Make
    let color: Color
    let series: InnerCleanliness
    let fuelType: FuelType
    let fuelLevel: Double
    let transmission: Transmission

    enum CodingKeys: String, CodingKey {
        case name, make, color, series
        case fuelType = "fuel_type"
        case fuelLevel = "fuel_level"
        case transmission
    }
}

enum Color: String, Codable {
    case midnightBlack = "midnight_black"
    case midnightBlue = "midnight_blue"
}

enum FuelType: String, Codable {
    case d = "D"
    case p = "P"
}

enum Make: String, Codable {
    case bmw = "BMW"
}

enum Transmission: String, Codable {
    case a = "A"
    case m = "M"
}

