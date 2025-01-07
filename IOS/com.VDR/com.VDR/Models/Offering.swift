import Foundation

struct OfferingsResponse: Codable {
    let total_count: Int
    let results: [Offering]
}

struct Offering: Codable, Identifiable {
    let id: String
    let name: String
    let type: String
    let description: String
    let cost: Double
    let imageUrls: [String]
    let hourlyBookingAllowed: Bool
    let features: [String]
} 
