//
//  locationRequest.swift
//  On The Map
//
//  Created by Norah Almaneea on 31/01/2021.
//

import Foundation

struct PostLocationRequest: Codable {
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
}
