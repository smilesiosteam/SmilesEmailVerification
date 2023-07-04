//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 26/06/2023.
//

import Foundation
import Combine
import NetworkingLayer

open class EmailVerificationHandler {
    public static let shared = EmailVerificationHandler()
    
    private var cancellables = Set<AnyCancellable>()
    
    public func sendEmailVerificationLink(baseURL: String, success: @escaping (SmilesEmailVerificationResponseModel) -> Void, failure: @escaping (NetworkError) -> Void) {
        let sendEmailVerificationLinkRequest = SmilesEmailVerificationRequestModel()
        
        let service = GetEmailVerificationRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: baseURL,
            endPoint: .sendVerifyEmailLink
        )
        
        service.sendEmailVerificationLinkService(request: sendEmailVerificationLinkRequest)
            .sink { completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    failure(error)
                default: break
                }
            } receiveValue: { response in
                success(response)
            }
        .store(in: &cancellables)
    }
}
