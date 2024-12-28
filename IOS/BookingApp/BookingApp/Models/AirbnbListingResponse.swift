//
//  AirbnbListingResponse.swift
//  BookingApp
//
//  Created by Abhra Ghosh on 27/12/24.
//

import Foundation

struct AirbnbListingResponse: Codable {
    let total_count: Int
    let results: [AirbnbListing]
    
}
