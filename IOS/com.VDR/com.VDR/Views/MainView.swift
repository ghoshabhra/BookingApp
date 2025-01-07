import SwiftUI

struct MainView: View {
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
            .navigationTitle("VDR")
        }
    }
} 
