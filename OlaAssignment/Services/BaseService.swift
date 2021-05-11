//
//  BaseService.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation

/**
  inherit BaseService class to other services to have basic setup of url params formation and setting header params
*/
internal class BaseService {
    
    func getHeaderParameters() -> [String: String] {
        let headerParams = ["Accept": "application/json", "Content-Type": "application/json"]
        return  headerParams
    }
    
    func setContentTypeToURLEncoded() -> Bool {
        return true
    }

}

fileprivate extension BaseService {
    
    /**
       set URL Params For Request
    */
    func setURLParamsForRequest(params: [String: Any]) -> String {
        var queryParams :String = ""
        var finalQueryParams : String = ""
        var iteration : Int = 0;
        for (key, value) in params {
            let keyStr :String = "\(key)"
            let valueStr :String = "\(value)"
            if(iteration == 0) {
                iteration = iteration + 1;
                queryParams = keyStr + "=" + valueStr
            } else {
                queryParams = "&" + keyStr + "=" + valueStr
            }
            finalQueryParams = finalQueryParams + queryParams
        }
        return finalQueryParams
    }
    
}
