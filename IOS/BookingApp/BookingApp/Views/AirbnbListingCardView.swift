//
//  AirbnbListingCardView.swift
//  BookingApp
//
//  Created by Abhra Ghosh on 27/12/24.
//

import SwiftUI

struct AirbnbListingCardView: View {
    let model: AirbnbListing
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: model.imageUrl ?? ""))
                .scaledToFit()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fill)
                .clipped()
            
            VStack{
                Text(model.name ?? "Listing")
                    .lineLimit(1)
                    .font(.title)
                    .bold()
                Text(model.type ?? "Listing")
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(3)
                    .font(.body)
            }
            
        }
    }
}
