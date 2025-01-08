import SwiftUI

struct OfferingDetailView: View {
    let offering: Offering
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Image Carousel
                TabView {
                    ForEach(offering.imageUrls.indices, id: \.self) { index in
                        CachedAsyncImage(url: URL(string: offering.imageUrls[index]))
                            .clipped()
                    }
                }
                .frame(height: 300)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(offering.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Price
                    VStack(alignment: .leading, spacing: 4) {
                        Text("₹\(String(format: "%.2f", offering.cost))")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(offering.hourlyBookingAllowed ? "per hour" : "per day")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Description
                    Text("About")
                        .font(.headline)
                    Text(offering.description)
                        .font(.body)
                    
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(offering.features, id: \.self) { feature in
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text(feature)
                                    .font(.subheadline)
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Book Now") {
                    // TODO: Implement booking functionality
                }
                .fontWeight(.semibold)
            }
        }
    }
} 