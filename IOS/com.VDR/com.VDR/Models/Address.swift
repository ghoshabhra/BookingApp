struct Address: Codable {
    let houseNumber: String
    let street: String
    let city: String
    let state: String
    let country: String
    let postalCode: String
    let googleMapLocationUrl: String
    let tag: String
}

struct AddressRequest: Codable {
    let houseNumber: String
    let street: String
    let city: String
    let state: String
    let country: String
    let postalCode: String
    let googleMapLocationUrl: String
    let tag: String
} 