import SwiftUI

struct AddressListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var sessionManager = SessionManager.shared
    @State private var addresses: [Address] = []
    @State private var isLoading = true
    @State private var error: Error?
    
    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView("Loading addresses...")
                } else if let error = error {
                    VStack {
                        Text("Error loading addresses")
                            .font(.headline)
                        Text(error.localizedDescription)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Button("Retry") {
                            loadAddresses()
                        }
                        .padding(.top)
                    }
                } else if addresses.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "mappin.slash")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("No Addresses Found")
                            .font(.headline)
                        
                        Text("You haven't added any addresses yet. Add your home address to get started.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Add Address")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(height: 44)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(22)
                                .padding(.horizontal, 40)
                                .padding(.top, 8)
                        }
                    }
                } else {
                    List(addresses, id: \.googleMapLocationUrl) { address in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.blue)
                                Text(address.tag)
                                    .font(.headline)
                            }
                            
                            Text("\(address.houseNumber), \(address.street)")
                            Text("\(address.city), \(address.state)")
                            Text("\(address.country) - \(address.postalCode)")
                            
                            if !address.googleMapLocationUrl.isEmpty {
                                Link(destination: URL(string: address.googleMapLocationUrl)!) {
                                    Text("Open in Maps")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
            .navigationTitle("Saved Addresses")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .task {
            loadAddresses()
        }
    }
    
    private func loadAddresses() {
        guard let userId = sessionManager.currentUser?.id else { return }
        
        isLoading = true
        error = nil
        
        Task {
            do {
                addresses = try await NetworkService.shared.fetchUserAddresses(userId: userId)
                await MainActor.run {
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.error = error
                    isLoading = false
                }
            }
        }
    }
} 