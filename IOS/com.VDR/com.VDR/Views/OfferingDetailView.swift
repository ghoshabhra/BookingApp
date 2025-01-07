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
                .frame(height: 300)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                VStack(alignment: .leading, spacing: 16) {
                    // Title and Type
                    VStack(alignment: .leading, spacing: 8) {
                        Text(offering.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(offering.type)
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    
                    // Price
                    Text("₹\(String(format: "%.2f", offering.cost))")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    // Description
                    Text("About")
                        .font(.headline)
                    Text(offering.description)
                        .font(.body)
                    
                    // Features
                    Text("Features")
                        .font(.headline)
                        .padding(.top)
                    
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