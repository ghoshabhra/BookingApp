import SwiftUI

struct AddAddressView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var sessionManager = SessionManager.shared
    
    @State private var houseNumber = ""
    @State private var street = ""
    @State private var city = ""
    @State private var state = ""
    @State private var country = ""
    @State private var postalCode = ""
    @State private var googleMapLocationUrl = ""
    @State private var tag = "HOME"
    
    @State private var isLoading = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Address Details")) {
                    TextField("House/Flat Number", text: $houseNumber)
                    TextField("Street", text: $street)
                    TextField("City", text: $city)
                    TextField("State", text: $state)
                    TextField("Country", text: $country)
                    TextField("Postal Code", text: $postalCode)
                    TextField("Google Maps URL (Optional)", text: $googleMapLocationUrl)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            .navigationTitle("Add Address")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveAddress()
                    }
                    .disabled(!isFormValid || isLoading)
                }
            }
            .alert("Address", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private var isFormValid: Bool {
        !houseNumber.isEmpty &&
        !street.isEmpty &&
        !city.isEmpty &&
        !state.isEmpty &&
        !country.isEmpty &&
        !postalCode.isEmpty
    }
    
    private func saveAddress() {
        guard let userId = sessionManager.currentUser?.id else {
            return
        }
        
        isLoading = true
        
        let address = AddressRequest(
            houseNumber: houseNumber,
            street: street,
            city: city,
            state: state,
            country: country,
            postalCode: postalCode,
            googleMapLocationUrl: googleMapLocationUrl,
            tag: tag
        )
        
        Task {
            do {
                try await NetworkService.shared.addUserAddress(userId: userId, address: address)
                await MainActor.run {
                    isLoading = false
                    dismiss()
                }
            } catch {
                await MainActor.run {
                    alertMessage = "Failed to save address: \(error.localizedDescription)"
                    showingAlert = true
                    isLoading = false
                }
            }
        }
    }
} 