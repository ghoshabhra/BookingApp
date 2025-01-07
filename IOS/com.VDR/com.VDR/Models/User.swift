struct User: Codable {
    let id: String?
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let listOfAddresses: [Address]?
    let role: String?
    let password: String
}

struct UserRegistrationRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let password: String
} 