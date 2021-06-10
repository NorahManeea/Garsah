//
//  udacityErrorResponse.swift
//  On The Map
//
//  Created by Norah Almaneea on 31/01/2021.
//

import Foundation

struct UdacityErrorResponse: Codable {
    let status: Int
    let error: String
}

extension UdacityErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
