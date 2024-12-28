//
//  AirbnbListingsView.swift
//  BookingApp
//
//  Created by Abhra Ghosh on 27/12/24.
//

import SwiftUI

struct AirbnbListingsView: View {
    @StateObject var viewModel = AirbnbListingsViewViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.listings){ listing in
                Text(listing.name)
                
            }
        
        }
        .onAppear{
            viewModel.fetchListings()
        }
    }
}
