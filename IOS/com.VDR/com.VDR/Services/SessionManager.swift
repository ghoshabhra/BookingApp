import Foundation

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published private(set) var currentUser: User?
    private let userDefaults = UserDefaults.standard
    private let userKey = "currentUser"
    
    private init() {
        // Load saved user on initialization
        loadSavedUser()
    }
    
    func saveUser(_ user: User) {
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(user)
            userDefaults.set(userData, forKey: userKey)
            DispatchQueue.main.async {
                self.currentUser = user
            }
        } catch {
            print("Error saving user: \(error)")
        }
    }
    
    func loadSavedUser() {
        guard let userData = userDefaults.data(forKey: userKey) else { return }
        
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: userData)
            DispatchQueue.main.async {
                self.currentUser = user
            }
        } catch {
            print("Error loading user: \(error)")
        }
    }
    
    func clearSession() {
        userDefaults.removeObject(forKey: userKey)
        DispatchQueue.main.async {
            self.currentUser = nil
        }
    }
} 