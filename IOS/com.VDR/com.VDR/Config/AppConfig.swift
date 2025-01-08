import Foundation

struct AppConfig {
    static let shared = AppConfig()
    
    #if targetEnvironment(simulator)
    let baseURL = "http://localhost:8080/api"
    #else
    let baseURL = "http://192.168.1.5:8080/api"  // Replace X with your local IP
    #endif
    
    let networkTimeout: TimeInterval = 30
} 