import SwiftUI

struct MainView: View {
    @StateObject private var sessionManager = SessionManager.shared
    
    var body: some View {
        TabView {
            OfferingsView()
                .tabItem {
                    Label("Services", systemImage: "list.bullet")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct ProfileView: View {
    @StateObject private var sessionManager = SessionManager.shared
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome, \(sessionManager.currentUser?.firstName ?? "")")
                    .font(.title)
                
                Button("Logout") {
                    SessionManager.shared.clearSession()
                }
                .padding()
            }
            .navigationTitle("Profile")
        }
    }
} 
