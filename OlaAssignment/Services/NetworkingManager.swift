//
//  NetworkingManager.swift
//  OlaAssignment
//
//  Created by Sanjeeva Reddy Nandela on 5/11/21.
//  Copyright © 2021 Sanjeeva Reddy Nandela. All rights reserved.
//

import Foundation

protocol NetworkingManager {
    func makeRequest<T: Decodable>(_ service: ServiceType, parameters: [String: String]?, body: Data?, httpMethod: HTTPMethod, httpHeaders: [String: String]?, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T?, ErrorResult>) -> Void)    
}

extension NetworkingManager {
    
    typealias CompletionHandler = (Decodable?, ErrorResult?) -> Void

    func makeRequest<T: Decodable>(_ service: ServiceType, parameters: [String: String]?, body: Data?, httpMethod: HTTPMethod, httpHeaders: [String: String]?, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T?, ErrorResult>) -> Void) {
        guard let url = buildUrl(service, queryParameters: parameters) else {
            completion(.failure(.network(errMessage: "invalid_url".localized()
                )))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        request.timeoutInterval = 5
        httpHeaders?.keys.forEach({ request.setValue(httpHeaders?[$0], forHTTPHeaderField: $0) })
        debugPrint("URL: \(url)")
        performTask(with: request, decodingType: T.self) { (json, error) in
            guard let json = json else {
                error != nil ? completion(.failure(error!)) : completion(.failure(.custom(errMessage: "invalid_data".localized())))
                return
            }
            guard let value = decode(json) else { completion(.failure(.custom(errMessage: "decoding_failed".localized()))); return }
            completion(.success(value))
        }
        
    }
    
}

// MARK: Networking: Private Methods

fileprivate extension NetworkingManager {
    
    func checkForAvailabilityOfInternetOrError(_ error: Error?, completion: CompletionHandler) {
        if error.debugDescription.contains(ErrorCodes.errorDomainToCheckInternetNotAvailable) {
            // This notification is to show no internet popup on current visible view controller
            NotificationCenter.default.post(name: OlaConstants.NotificationConstants.ShowInternetPopup, object: nil)
        } else {
            completion(nil, .network(errMessage: error?.localizedDescription ?? ""))
        }
    }
    
    func buildUrl(_ urlString: ServiceType, queryParameters: [String: String]?) -> URL? {
        let baseUrl = EnvironmentHelper().getBaseUrl(service: urlString)
        let finalUrl = baseUrl + urlString.rawValue
        guard var urlComponents = URLComponents(string: finalUrl) else {
            return nil
        }
        let queryItems = queryParameters?.keys.map({ return URLQueryItem(name: $0, value: queryParameters?[$0]) })
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    func performTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completion: @escaping CompletionHandler) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            debugPrint("Status Code: \(httpResponse?.statusCode ?? 0)")
            if let error = error {
                if error.localizedDescription.contains(ErrorCodes.requestTimeout) {
                    completion(nil, .network(errMessage: "request_time_out_error".localized()))
                } else {
                    self.checkForAvailabilityOfInternetOrError(error, completion: completion)
                }
                return
            }
            guard  httpResponse?.statusCode == 200 || httpResponse?.statusCode == 201 else {
                completion(nil, .network(errMessage: "something_went_wong".localized()))
                return
            }
            guard let data = data else {
                completion(nil, .custom(errMessage: "data_error".localized()))
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            debugPrint("data : \(str)")
            self.decode(withData: data, decodingType: decodingType, completion: completion)
        }.resume()
        
    }
    
    func decode<T:Decodable>(withData data: Data, decodingType: T.Type, completion: CompletionHandler) {
        if decodingType.self == Data?.self {
            completion(data, nil)
        } else {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let genericModel = try decoder.decode(decodingType, from: data)
                completion(genericModel, nil)
            } catch let err {
                debugPrint("Decoding error: \(err)")
                if data.isEmpty {
                    completion(nil, .network(errMessage: "empty_data".localized()))
                }else {
                    completion(nil, .parser(errMessage: err.localizedDescription))
                }
            }
        }
    }
    
}
