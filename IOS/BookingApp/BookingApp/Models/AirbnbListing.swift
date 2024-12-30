//
//  AirbnbListing.swift
//  BookingApp
//
//  Created by Abhra Ghosh on 27/12/24.
//

import Foundation

struct AirbnbListing: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let type: String
    let cost: Double
    let imageUrl: String
}
