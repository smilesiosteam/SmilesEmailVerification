//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 26/06/2023.
//

import Foundation
import NetworkingLayer

fileprivate typealias Headers = [String: String]
// if you wish you can have multiple services like this in a project
enum EmailVerificationRequestBuilder {
    
    // organise all the end points here for clarity
    case getEmailVerificationLink(request: SmilesEmailVerificationRequestModel)

    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    var httpMethod: SmilesHTTPMethod {
        switch self {
        case .getEmailVerificationLink:
            return .POST
        }
    }
    
    // compose the NetworkRequest
    func createRequest(baseUrl: String, endPoint: EmailVerificationEndPoints) -> NetworkRequest {
        var headers: Headers = [:]

        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["CUSTOM_HEADER"] = "pre_prod"
        
        return NetworkRequest(url: getURL(from: baseUrl, for: endPoint), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .getEmailVerificationLink(let request):
            return request
        }
    }
    
    // compose urls for each request
    func getURL(from baseUrl: String, for endPoint: EmailVerificationEndPoints) -> String {
        
        let endPoint = endPoint.serviceEndPoints
        switch self {
        case .getEmailVerificationLink:
            return "\(baseUrl)\(endPoint)"
        }
        
    }
}
