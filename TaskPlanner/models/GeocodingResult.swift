//
//  GeocodingResult.swift
//  TaskPlanner
//
//  Created by Bhavesh Agrawal on 07/06/2019.
//  Copyright © 2019 Bhavesh Agrawal. All rights reserved.
//

import Foundation

struct GeocodingResult: Decodable {
    
    let status: String
    let results: [GeocodingResultItem]
    
    enum CodingKeys: String, CodingKey {
        case status
        case results
    }
}

struct GeocodingResultItem: Decodable {
    
    let formattedAddress: String
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
    }
}
