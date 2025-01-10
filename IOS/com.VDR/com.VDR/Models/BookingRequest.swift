import Foundation

struct BookingRequest: Codable {
    let userId: String
    let offeringId: String      // Kept as offeringId (lowercase 'd')
    let startDateTime: String
    let endDateTime: String
    let totalAmount: Double
    let durationUnits: Int
    let hourlyBooking: Bool     // Changed from isHourlyBooking to hourlyBooking
    
    init(userId: String, offering: Offering, fromDate: Date, toDate: Date, totalAmount: Double, durationUnits: Int) {
        self.userId = userId
        self.offeringId = offering.id
        
        // Create ISO8601 formatter with fractional seconds
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        self.startDateTime = formatter.string(from: fromDate)
        self.endDateTime = formatter.string(from: toDate)
        self.totalAmount = totalAmount
        self.durationUnits = durationUnits
        self.hourlyBooking = offering.hourlyBookingAllowed
    }
} 