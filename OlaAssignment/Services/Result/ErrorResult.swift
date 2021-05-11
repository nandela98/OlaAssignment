//
//  ErrorResult.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation

enum ErrorResult : Error {
    case network(errMessage: String)
    case parser(errMessage: String)
    case custom(errMessage: String)
    case applicationError(attributedMessage: NSAttributedString, stringMessage: String?)
    
    var localizedDescription: String {
        switch self {
        case .network(let value):   return value
        case .parser(let value):    return value
        case .custom(let value):    return value
            
        case .applicationError(attributedMessage: _, stringMessage: let stringMessage):
            return stringMessage ?? ""
        }
    }
    
    var localizedAttributedStringDescription: NSAttributedString {
        switch self {
        case .network(_): return NSAttributedString(string: "")
        case .parser(_) : return NSAttributedString(string: "")
        case .custom(_) : return NSAttributedString(string: "")
        
        case .applicationError(attributedMessage: let attributedMessage, stringMessage: _):
            return attributedMessage
        }
    }
    
    var errorType: Int {
        switch self {
            
        case .network(errMessage:  _):
            return 1
        case .parser(errMessage:  ):
            return 2
        case .custom(errMessage: ):
            return 3
        case .applicationError(attributedMessage: _, stringMessage:_):
            return 4
        }
    }
}
