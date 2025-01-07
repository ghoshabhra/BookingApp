import SwiftUI

struct OfferingCard: View {
    let offering: Offering
    @State private var currentImageIndex = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image Carousel
            TabView(selection: $currentImageIndex) {
                ForEach(offering.imageUrls.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: offering.imageUrls[index])) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    }
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
                
                Text(offering.type)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(offering.description)
                    .font(.body)
                    .lineLimit(3)
                
                Text("₹\(String(format: "%.2f", offering.cost))")
                    .font(.title3)
                    .fontWeight(.semibold)
                
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