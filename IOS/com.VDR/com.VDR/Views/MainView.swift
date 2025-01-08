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
        .background(Color.appBackground)
    }
}

struct ProfileView: View {
    @StateObject private var sessionManager = SessionManager.shared
    @State private var showingDeleteConfirmation = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    HStack {
                        Button(action: {
                            // Back action
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                        
                        Button("Edit profile") {
                            // Edit profile action
                        }
                        .foregroundColor(.green)
                    }
                    .padding(.horizontal)
                    
                    // Profile Image and Name
                    VStack(spacing: 16) {
                        ProfileImageView()
                        
                        Text(sessionManager.currentUser?.firstName ?? "User")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "envelope")
                            Text(sessionManager.currentUser?.email ?? "email@example.com")
                                .foregroundColor(.gray)
                        }
                        
                        Button("Verify") {
                            // Verify action
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .cornerRadius(20)
                    }
                    
                    // Favorite Locations Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Favorite locations")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        Button(action: {
                            // Add home address action
                        }) {
                            HStack {
                                Image(systemName: "house")
                                    .frame(width: 24)
                                Text("Add home address")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.white)
                        }
                        .foregroundColor(.primary)
                        
                        Divider()
                        
                        Button(action: {
                            // Add work address action
                        }) {
                            HStack {
                                Image(systemName: "briefcase")
                                    .frame(width: 24)
                                Text("Add work address")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.white)
                        }
                        .foregroundColor(.primary)
                    }
                    
                    // Account Actions
                    VStack(spacing: 16) {
                        Button(action: {
                            SessionManager.shared.clearSession()
                        }) {
                            HStack {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .frame(width: 24)
                                Text("Log out")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.white)
                        }
                        .foregroundColor(.primary)
                        
                        Divider()
                        
                        Button(action: {
                            showingDeleteConfirmation = true
                        }) {
                            HStack {
                                Image(systemName: "trash")
                                    .frame(width: 24)
                                Text("Delete account")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.white)
                        }
                        .foregroundColor(.primary)
                    }
                }
                .padding(.vertical)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
            .navigationBarHidden(true)
            .alert("Delete Account", isPresented: $showingDeleteConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    deleteAccount()
                }
            } message: {
                Text("Are you sure you want to delete your account? This action cannot be reversed and all your data will be permanently deleted.")
            }
        }
    }
    
    private func deleteAccount() {
        guard let userId = sessionManager.currentUser?.id else {
            return
        }
        
        Task {
            do {
                try await NetworkService.shared.deleteUser(id: userId)
                await MainActor.run {
                    // After successful deletion, log out the user
                    SessionManager.shared.clearSession()
                }
            } catch {
                // Handle error if needed
                Logger.log("Failed to delete account: \(error)", level: .error)
                // You might want to show an error alert here
            }
        }
    }
}

#Preview {
    ProfileView()
} 
