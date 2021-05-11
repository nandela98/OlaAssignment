//
//  Result.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation

enum Result<T, E:Error> {
    case success(T?)
    case failure(E?)
}
