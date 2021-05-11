//
//  ErrorModel.swift
//  Assignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation

struct ErrorModel: Error {
    // MARK: - Properties
    var message: String
}

struct ErrorCodes {
    static let errorCode404 = "404"
    static let errorDomainToCheckInternetNotAvailable = "NSURLErrorDomain Code=-1009"
    static let requestTimeout = "The request timed out."
}
