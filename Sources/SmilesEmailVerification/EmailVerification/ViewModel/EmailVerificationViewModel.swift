//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 04/07/2023.
//

import Foundation
import Combine
import NetworkingLayer

class EmailVerificationViewModel {
    
    // MARK: - INPUT. View event methods
    enum Input {
        case sendEmailVerificationLink(baseUrl: String)
    }
    
    enum Output {
        case sendEmailVerificationLinkDidSucceed(response: SmilesEmailVerificationResponseModel)
        case sendEmailVerificationLinkDidFail(error: Error)
    }
    
    // MARK: -- Variables
    private var output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
}

extension EmailVerificationViewModel {
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .sendEmailVerificationLink(let baseUrl):
                self?.sendEmailVerificationLink(baseUrl: baseUrl)
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    func sendEmailVerificationLink(baseUrl: String) {
        let sendEmailVerificationLinkRequest = SmilesEmailVerificationRequestModel()
        
        let service = GetEmailVerificationRepository(
            networkRequest: NetworkingLayerRequestable(requestTimeOut: 60),
            baseUrl: baseUrl,
            endPoint: .sendVerifyEmailLink
        )
        
        service.sendEmailVerificationLinkService(request: sendEmailVerificationLinkRequest)
            .sink { [weak self] completion in
                debugPrint(completion)
                switch completion {
                case .failure(let error):
                    self?.output.send(.sendEmailVerificationLinkDidFail(error: error))
                case .finished:
                    debugPrint("nothing much to do here")
                }
            } receiveValue: { [weak self] response in
                self?.output.send(.sendEmailVerificationLinkDidSucceed(response: response))
            }
        .store(in: &cancellables)
    }
}

