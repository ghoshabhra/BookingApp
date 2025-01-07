import SwiftUI

struct OfferingsView: View {
    @State private var offerings: [Offering] = []
    @State private var isLoading = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            Group {
                if isLoading && offerings.isEmpty {
                    ProgressView("Loading offerings...")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(offerings) { offering in
                                OfferingCard(offering: offering)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Services")
            .alert("Error", isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .task {
                // Clear any stale state
                isLoading = false
                await loadOfferings()
            }
            .refreshable {
                await loadOfferings()
            }
        }
    }
    
    private func loadOfferings() async {
        if isLoading {
            Logger.log("Loading already in progress, skipping", level: .warning)
            return
        }
        
        Logger.log("Starting to load offerings")
        isLoading = true
        
        do {
            let response = try await NetworkService.shared.fetchOfferings()
            
            await MainActor.run {
                offerings = response.results
                isLoading = false
                Logger.log("Successfully loaded \(offerings.count) offerings")
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                showingError = true
                Logger.log("Failed to load offerings: \(error)", level: .error)
                isLoading = false
                offerings = [] // Reset offerings on error
            }
        }
    }
}

#Preview {
    OfferingsView()
} 