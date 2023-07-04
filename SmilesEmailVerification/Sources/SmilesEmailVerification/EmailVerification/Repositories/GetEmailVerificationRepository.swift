//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 26/06/2023.
//

import Foundation
import Combine
import NetworkingLayer

protocol GetEmailVerificationServiceable {
    func sendEmailVerificationLinkService(request: SmilesEmailVerificationRequestModel) -> AnyPublisher<SmilesEmailVerificationResponseModel, NetworkError>
}

class GetEmailVerificationRepository {
    private var networkRequest: Requestable
    private var baseUrl: String
    private var endPoint: EmailVerificationEndPoints

  // inject this for testability
    init(networkRequest: Requestable, baseUrl: String, endPoint: EmailVerificationEndPoints) {
        self.networkRequest = networkRequest
        self.baseUrl = baseUrl
        self.endPoint = endPoint
    }
  
    func sendEmailVerificationLinkService(request: SmilesEmailVerificationRequestModel) -> AnyPublisher<SmilesEmailVerificationResponseModel, NetworkError> {
        let endPoint = EmailVerificationRequestBuilder.getEmailVerificationLink(request: request)
        let request = endPoint.createRequest(
            baseUrl: self.baseUrl,
            endPoint: self.endPoint
        )
        
        return self.networkRequest.request(request)
    }
}
