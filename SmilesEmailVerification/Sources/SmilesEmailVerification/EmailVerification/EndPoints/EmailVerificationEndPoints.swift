//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 26/06/2023.
//

import Foundation

public enum EmailVerificationEndPoints: String, CaseIterable {
    case sendVerifyEmailLink
}

extension EmailVerificationEndPoints {
    var serviceEndPoints: String {
        switch self {
        case .sendVerifyEmailLink:
            return "profile/send-verification-email"
        }
    }
}
