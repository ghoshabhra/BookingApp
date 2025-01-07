import Foundation

struct AppConfig {
    static let shared = AppConfig()
    
    let baseURL = "http://localhost:8080/api"
    let networkTimeout: TimeInterval = 30
} 