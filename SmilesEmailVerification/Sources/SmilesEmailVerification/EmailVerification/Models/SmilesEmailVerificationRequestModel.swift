//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 26/06/2023.
//

import Foundation
import SmilesBaseMainRequestManager

// Inherit SmilesBaseMainRequest instead of Codable in case you have some base class.
class SmilesEmailVerificationRequestModel: SmilesBaseMainRequest {

    // MARK: - Model Variables
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }

    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
