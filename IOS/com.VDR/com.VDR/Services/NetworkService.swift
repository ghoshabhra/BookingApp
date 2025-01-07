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
} 