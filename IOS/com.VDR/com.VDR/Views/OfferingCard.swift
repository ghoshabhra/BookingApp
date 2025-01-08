import SwiftUI

struct OfferingCard: View {
    let offering: Offering
    @State private var currentImageIndex = 0
    
    var body: some View {
        NavigationLink(destination: OfferingDetailView(offering: offering)) {
            VStack(alignment: .leading, spacing: 12) {
                // Image Carousel
                TabView(selection: $currentImageIndex) {
                    ForEach(offering.imageUrls.indices, id: \.self) { index in
                        CachedAsyncImage(url: URL(string: offering.imageUrls[index]))
                            .clipped()
                    }
                }
                .frame(height: 200)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                // Content
                VStack(alignment: .leading, spacing: 8) {
                    Text(offering.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(offering.description)
                        .font(.body)
                        .lineLimit(3)
                        .foregroundColor(.primary)
                    
                    Text("₹\(String(format: "%.2f", offering.cost))")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    // Features
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(offering.features, id: \.self) { feature in
                                Text(feature)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    OfferingCard(offering: Offering(
        id: "1",
        name: "Dog Boarding",
        type: "Boarding",
        description: "Comfortable stay for your furry friend",
        cost: 1000.0,
        imageUrls: [
            "https://example.com/image1.jpg",
            "https://example.com/image2.jpg",
            "https://example.com/image3.jpg"
        ],
        hourlyBookingAllowed: true,
        features: ["24/7 Care", "Spacious Kennels", "Daily Walks"]
    ))
} 