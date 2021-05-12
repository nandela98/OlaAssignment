//
//  Result.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation

/// on success/failure of api call - returns result as generic 
enum Result<T, E:Error> {
    case success(T?)
    case failure(E?)
}
