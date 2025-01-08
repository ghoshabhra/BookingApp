import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                // Logo/Title
                Text("Welcome to VDR")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                // Sign in options
                VStack(spacing: 16) {
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Sign in with email")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                    
                    // Sign up link
                    HStack(spacing: 4) {
                        Text("New here?")
                            .foregroundColor(.secondary)
                        
                        NavigationLink {
                            RegistrationView()
                        } label: {
                            Text("Sign up")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    WelcomeView()
} 