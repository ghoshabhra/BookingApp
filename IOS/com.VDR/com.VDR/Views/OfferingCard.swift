import SwiftUI

struct OfferingCard: View {
    let offering: Offering
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image
            AsyncImage(url: URL(string: offering.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(height: 200)
            .clipped()
            
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
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
} 