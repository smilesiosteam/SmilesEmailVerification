//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 26/06/2023.
//

import Foundation
import NetworkingLayer

public class SmilesEmailVerificationResponseModel: BaseMainResponse {
    public let status: Int?
    public let successMessage: String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case successMessage = "successMessage"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        successMessage = try values.decodeIfPresent(String.self, forKey: .successMessage)
        try super.init(from: decoder)
    }

}
