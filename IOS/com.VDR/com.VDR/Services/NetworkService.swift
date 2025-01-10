import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
}

class NetworkService {
    static let shared = NetworkService()
    private let baseURL = AppConfig.shared.baseURL
    
    func registerUser(_ request: UserRegistrationRequest) async throws -> User {
        guard let url = URL(string: "\(baseURL)/user") else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(request)
        urlRequest.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func login(_ request: LoginRequest) async throws -> User {
        guard let url = URL(string: "\(baseURL)/user/login") else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(request)
        urlRequest.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func fetchOfferings() async throws -> OfferingsResponse {
        Logger.log("Initiating offerings fetch request to \(baseURL)/offerings")
        
        guard let url = URL(string: "\(baseURL)/offerings") else {
            Logger.log("Invalid URL: \(baseURL)/offerings", level: .error)
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 30
        
        do {
            Logger.log("Sending request to fetch offerings")
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                Logger.log("Invalid response type", level: .error)
                throw NetworkError.invalidResponse
            }
            
            Logger.log("Received response with status code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                Logger.log("HTTP Error: Status code \(httpResponse.statusCode)", level: .error)
                throw NetworkError.invalidResponse
            }
            
            // Log raw response for debugging
            Logger.log("Raw response: \(String(data: data, encoding: .utf8) ?? "Unable to decode response")")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let offerings = try decoder.decode(OfferingsResponse.self, from: data)
            Logger.log("Successfully decoded \(offerings.results.count) offerings")
            
            return offerings
        } catch {
            Logger.log("Failed to fetch offerings: \(error.localizedDescription)", level: .error)
            throw error
        }
    }
    
    func deleteUser(id: String) async throws {
        Logger.log("Initiating user deletion request for id: \(id)")
        
        guard let url = URL(string: "\(baseURL)/user?id=\(id)") else {
            Logger.log("Invalid URL for user deletion", level: .error)
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        
        do {
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                Logger.log("Invalid response type", level: .error)
                throw NetworkError.invalidResponse
            }
            
            Logger.log("Received response with status code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                Logger.log("HTTP Error: Status code \(httpResponse.statusCode)", level: .error)
                throw NetworkError.invalidResponse
            }
            
            Logger.log("Successfully deleted user")
        } catch {
            Logger.log("Failed to delete user: \(error.localizedDescription)", level: .error)
            throw error
        }
    }
    
    func addUserAddress(userId: String, address: AddressRequest) async throws {
        Logger.log("Adding address for user: \(userId)")
        
        guard let url = URL(string: "\(baseURL)/user/address?id=\(userId)") else {
            Logger.log("Invalid URL for adding address", level: .error)
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        
        let jsonData = try JSONEncoder().encode(address)
        urlRequest.httpBody = jsonData
        
        do {
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                Logger.log("Invalid response type", level: .error)
                throw NetworkError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                Logger.log("HTTP Error: Status code \(httpResponse.statusCode)", level: .error)
                throw NetworkError.invalidResponse
            }
            
            Logger.log("Successfully added address")
        } catch {
            Logger.log("Failed to add address: \(error.localizedDescription)", level: .error)
            throw error
        }
    }
    
    func fetchUserAddresses(userId: String) async throws -> [Address] {
        Logger.log("Fetching addresses for user: \(userId)")
        
        guard let url = URL(string: "\(baseURL)/user/address?id=\(userId)") else {
            Logger.log("Invalid URL for fetching addresses", level: .error)
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                Logger.log("Invalid response type", level: .error)
                throw NetworkError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                Logger.log("HTTP Error: Status code \(httpResponse.statusCode)", level: .error)
                throw NetworkError.invalidResponse
            }
            
            let addresses = try JSONDecoder().decode([Address].self, from: data)
            Logger.log("Successfully fetched \(addresses.count) addresses")
            return addresses
        } catch {
            Logger.log("Failed to fetch addresses: \(error.localizedDescription)", level: .error)
            throw error
        }
    }
    
    func createBooking(_ request: BookingRequest) async throws {
        Logger.log("Creating booking for offering: \(request.offeringId)")
        
        guard let url = URL(string: "\(baseURL)/booking") else {
            Logger.log("Invalid URL for creating booking", level: .error)
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("*/*", forHTTPHeaderField: "accept")
        
        let jsonData = try JSONEncoder().encode(request)
        
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            Logger.log("Booking request payload: \(jsonString)")
        }
        
        urlRequest.httpBody = jsonData
        
        do {
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                Logger.log("Invalid response type", level: .error)
                throw NetworkError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                Logger.log("HTTP Error: Status code \(httpResponse.statusCode)", level: .error)
                throw NetworkError.invalidResponse
            }
            
            Logger.log("Successfully created booking")
        } catch {
            Logger.log("Failed to create booking: \(error.localizedDescription)", level: .error)
            throw error
        }
    }
} 