import SwiftUI

struct LoginView: View {
    @StateObject private var sessionManager = SessionManager.shared
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        Form {
            Section(header: Text("Login Details")) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
            }
            
            Section {
                Button(action: login) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(isLoading || !isFormValid)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.appBackground)
        .navigationTitle("Login")
        .alert("Login", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    private func login() {
        guard isFormValid else { return }
        
        let request = LoginRequest(
            email: email,
            password: password
        )
        
        isLoading = true
        
        Task {
            do {
                let user = try await NetworkService.shared.login(request)
                await MainActor.run {
                    SessionManager.shared.saveUser(user)
                    isLoading = false
                    clearForm()
                }
            } catch {
                await MainActor.run {
                    alertMessage = "Login failed: \(error.localizedDescription)"
                    showingAlert = true
                    isLoading = false
                }
            }
        }
    }
    
    private func clearForm() {
        email = ""
        password = ""
    }
}

#Preview {
    NavigationView {
        LoginView()
    }
} 